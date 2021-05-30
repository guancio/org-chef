#!/usr/bin/python3

from orgparse import load, loads
import argparse
import sys
from miio import IHCooker, ihcooker

parser = argparse.ArgumentParser(description='Control induction cooker.')
parser.add_argument('--ip', help='Device IP', required=True)
parser.add_argument('--token', help='Device Token', required=True)
parser.add_argument('--start', dest='action', action='store_const',
                    const='start', default='status',
                    help='Start cooking')
args = parser.parse_args()
cooker = IHCooker(args.ip, args.token)

if args.action == 'status':
    print(cooker.status())
    exit(0)


if args.action == 'start':
    print("Reading recipe from stdin")
    data = "".join(sys.stdin.readlines())
    root = loads(data.strip())
    print("Cooking %s" % root[1].heading)
    phases = [{'mode': 'heat_until_temp',
               'temp': int(phase.get_property('temperature')),
               'thresh' : int(phase.get_property('threshold')),
               'fire' : int(phase.get_property('fire'))
    } for phase in root[1].children]
    profile = ihcooker.CookProfile(cooker.model)
    profile.set_recipe_phases(phases)
    cooker.start(profile)
