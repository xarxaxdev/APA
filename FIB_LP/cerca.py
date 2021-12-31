# -*- coding: utf-8 -*-

import sys
import argparse
import urllib.request
import math
import unicodedata
import csv

from functools import reduce
from ast import literal_eval
from html.parser import HTMLParser
from math import sin, cos, sqrt, atan2, radians


stations = []
landmarks = []
# PART PER TENIR LES ESTACIONS


class Station:

    def afegir_id(self, nom):
        self.id = nom
        self.streetn = ""

    def afegir_lat(self, nom):
        self.lat = nom

    def afegir_long(self, nom):
        self.long = nom

    def afegir_bikes(self, nom):
        self.bikes = nom

    def afegir_slots(self, nom):
        self.slots = nom

    def afegir_street(self, nom):
        self.street = nom.split('[')[1]

    def afegir_streetn(self, nom):
        self.streetn = nom


# fem el nostre HTMLparser que extengui de HTMLparser
class MyHTMLParser(HTMLParser):

    currentstation = Station()
    currenttag = ""

    def handle_starttag(self, tag, attrs):
        self.currenttag = tag
        if tag == 'station':
            self.currentstation = Station()

    def handle_endtag(self, tag):
        self.currenttag = ""
        if tag == 'station':
            stations.append(self.currentstation)

    def handle_data(self, data):
        if self.currenttag == 'id':
            self.currentstation.afegir_id(data)
        if self.currenttag == 'lat':
            self.currentstation.afegir_lat(data)
        if self.currenttag == 'long':
            self.currentstation.afegir_long(data)
        if self.currenttag == 'bikes':
            self.currentstation.afegir_bikes(data)
        if self.currenttag == 'slots':
            self.currentstation.afegir_slots(data)
        if self.currenttag == 'streetnumber':
            self.currentstation.afegir_streetn(data)

    def unknown_decl(self, data):
        if(self.currenttag == 'street'):
            self.currentstation.afegir_street(data)


def printstation(x):
    print("station: " + str(x.id) + " lat: " +
          str(x.lat) + " long: " + str(x.long))
    print("bikes: " + str(x.bikes) + " slots: " + str(x.slots))


"""funcions per a definir punts d'interès"""


class Landmark:
    def __init__(self):
        self.name = ""
        self.lat = ""
        self.long = ""
        self.address = ""
        self.district = ""
        self.barri = ""
        self.content = ""
        self.descripcio_curta_pics = ""

    def afegir_name(self, nom):
        self.name = nom

    def afegir_lat(self, nom):
        self.lat = nom

    def afegir_long(self, nom):
        self.long = nom

    def afegir_address(self, nom):
        self.address = nom

    def afegir_district(self, nom):
        self.district = nom

    def afegir_barri(self, nom):
        self.barri = nom

    def afegir_descripcio_curta_pics(self, nom):
        self.descripcio_curta_pics = nom

    def afegir_content(self, nom):
        self.content = nom

# fem el nostre HTMLparser que extengui de HTMLparser


class MyHTMLParser2(HTMLParser):

    currentlandmark = Landmark()
    currenttag = ""

    def handle_starttag(self, tag, attrs):
        self.currenttag = tag
        if tag == 'row':
            self.currentlandmark = Landmark()

    def handle_endtag(self, tag):
        self.currenttag = ""
        if tag == 'row':
            landmarks.append(self.currentlandmark)

    def handle_data(self, data):
        if self.currenttag == 'name':
            self.currentlandmark.afegir_name(data)
        if self.currenttag == 'gmapx':
            self.currentlandmark.afegir_lat(data)
        if self.currenttag == 'gmapy':
            self.currentlandmark.afegir_long(data)
        if self.currenttag == 'address':
            self.currentlandmark.afegir_address(data)
        if self.currenttag == 'district':
            self.currentlandmark.afegir_district(data)
        if self.currenttag == 'barri':
            self.currentlandmark.afegir_barri(data)
        if self.currenttag == 'descripcio-curta-pics':
            self.currentlandmark.afegir_descripcio_curta_pics(data)
        if self.currenttag == 'content':
            self.currentlandmark.afegir_content(data)


def printlandmark(x):
    print("landmark: " + str(x.name) + " lat: " +
          str(x.lat) + " long: " + str(x.long))
    print("barri: " + str(x.barri) + " district: " +
          str(x.district) + " address: " + str(x.address))


def buscarindef(mylm, x):
    # print(mylm.name.find(x))
    # print(mylm.address.find(x))
    # print(mylm.district.find(x))
    # print( mylm.barri.find(x))
    a = (-1 != noaccents(mylm.address).lower().find(x)
         ) or(-1 != noaccents(mylm.name).lower().find(x))
    b = (-1 != noaccents(mylm.district).lower().find(x)
         ) or (-1 != noaccents(mylm.barri).lower().find(x))
    return a or b


def buscardef(mylm, field, value):
    if field == 'location':
        x = False
        x = x or (-1 != noaccents(mylm.address).lower().find(value))
        x = x or (-1 != noaccents(mylm.district).lower().find(value))
        x = x or (-1 != noaccents(mylm.barri).lower().find(value))
        return x
    if field == 'name':
        return (-1 != noaccents(mylm.name).lower().find(value))
    if field == 'content':
        return (-1 != noaccents(mylm.content).lower().find(value))
    return false


def intersect(a, b):
    """ return the intersection of two lists """
    return list(set(a) & set(b))


def union(a, b):
    """ return the union of two lists """
    return list(set(a) | set(b))


def noaccents(s):
    return ''.join(c for c in unicodedata.normalize('NFD', s)
                   if unicodedata.category(c) != 'Mn')


def landmarksrec(consulta):
    filtrado = []
    if isinstance(consulta, str):
        for x in landmarks:
            if buscarindef(x, consulta):
                filtrado.append(x)
        return filtrado
    if isinstance(consulta, list):
        for x in consulta:
            filtrado = union(filtrado, landmarksrec(x))
        return filtrado
    if isinstance(consulta, tuple):
        consulta0, *consulta = consulta
        filtrado = landmarksrec(consulta0)
        for x in consulta:
            filtrado = intersect(filtrado, landmarksrec(x))
        return filtrado
    if isinstance(consulta, dict):
        field0, *rest = list(consulta.keys())

        def andmore(x, y): return x and y

        def ormore(x, y): return x or y
        # cas inicial per fer l'and
        if isinstance(consulta.get(field0), list):
            for x in landmarks:
                if reduce(ormore, [buscardef(x, field0, val)
                                   for val in consulta.get(field0)], False):
                    filtrado.append(x)
        elif isinstance(consulta.get(field0), tuple):
            for x in landmarks:
                if reduce(andmore, [buscardef(x, field0, val)
                                    for val in consulta.get(field0)], True):
                    filtrado.append(x)
        else:
            for x in landmarks:
                if buscardef(x, field0, consulta[field0]):
                    filtrado.append(x)

        temp = []
        # resta de casos
        for field in list(rest):
            if isinstance(consulta.get(field), list):
                for x in landmarks:
                    if reduce(ormore, [buscardef(x, field, val)
                                       for val in consulta.get(field)], False):
                        temp.append(x)
            elif isinstance(consulta.get(field), tuple):
                for x in landmarks:
                    if reduce(andmore, [buscardef(x, field, val)
                                        for val in consulta.get(field)], True):
                        temp.append(x)
            else:
                for x in landmarks:
                    if buscardef(x, field, consulta[field]):
                        temp.append(x)
            filtrado = intersect(filtrado, temp)
        return filtrado
    return filtrado


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Especifica --lan o --key.')
    parser.add_argument('--lan', help='Language', default="cat")
    parser.add_argument('--key', help='Specify keywords')

    args = parser.parse_args()
    if args.key is None:
        print("Invalid key")
        exit()
    consulta = literal_eval(noaccents(args.key).lower())
    parser = MyHTMLParser()
    file = urllib.request.urlopen(
        "http://wservice.viabicing.cat/v1/getstations.php?v=1")
    htmlSource = file.read().decode('utf-8')
    file.close()
    parser.feed(str(htmlSource))
    if args.lan == 'cat':
        args.lan = ''
    else:
        args.lan = '-' + args.lan
    parser2 = MyHTMLParser2()
    file2 = urllib.request.urlopen(
        "http://www.bcn.cat/tercerlloc/pits_opendata" + args.lan + '.xml')
    htmlSource2 = file2.read().decode('utf-8')
    file2.close()
    parser2.feed(str(htmlSource2))
    filtrado = landmarksrec(consulta)

    def print_table(data):
        print ('<table style="width:100%">')
        counter = 0
        print('<tr><th>Punt interes</th> <th>On aparcar</th>' +
              '<th>On trobar bici</th></tr>')
        for row in data:
            if counter == 0:
                print ('<tr>')
            print ('    <td>%s</td>' % row)
            counter += 1
            if counter == 3:
                print ('</tr>')
                counter = 0
        print ('</table>')

    def distancex(lat1, lon1, lat2, lon2):

        # approximate radius of earth in km
        R = 6373.0

        lat1 = radians(float(lat1))
        lon1 = radians(float(lon1))
        lat2 = radians(float(lat2))
        lon2 = radians(float(lon2))

        dlon = lon2 - lon1
        dlat = lat2 - lat1

        a = sin(dlat / 2)**2 + cos(lat1) * cos(lat2) * sin(dlon / 2)**2
        c = 2 * atan2(sqrt(a), sqrt(1 - a))

        distance = R * c
        return distance * 1000

    def distance(a, b):
        return distancex(a.lat, a.long, b.lat, b.long)
    if(len(filtrado) == 1):  # or True):
        print("""<!DOCTYPE html>
        <html>
        <head>
        <meta charset="utf-8">
        <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            width:30%;
        }
        table tr:nth-child(even) {
            background-color: #B2DFDB;
        }
        table tr:nth-child(odd) {
           background-color:#80CBC4;
        }
        </style>
        </head>
        <body>""")
        cur = filtrado[0]
        row = []
        row.append('Nom: ' + cur.name + "<br>"
                   'Adreça: ' + cur.address + "<br>" +
                   'Districte: ' + cur.district + '<br>' +
                   'Barri: ' + cur.barri + '<br>'
                   'Descripcio: ' + cur.content)
        closenuf = list(filter(lambda x: (distance(x, cur) <= 500), stations))
        candidates = list(filter(lambda x: int(x.slots) > 0, closenuf))
        ordered = sorted(candidates, key=(
            lambda x: int(x.slots)), reverse=True)
        ordered = ordered[0:5]
        ordered.reverse()
        closest = ""
        for x in ordered:
            closest = 'ID: ' + x.id + ' street: ' + x.street + ',' +\
                x.streetn + '  slots: ' + x.slots + '  distance: ' + \
                str(int(distance(x, cur))) + 'm  <br>' + closest
        row.append(closest)

        candidates = list(filter(lambda x: int(x.bikes) > 0, closenuf))
        ordered = sorted(candidates, key=lambda x: int(x.bikes))
        ordered = ordered[0:5]
        ordered.reverse()
        closest = ""
        for x in ordered:
            closest = 'ID: ' + x.id + ' street: ' + x.street + ',' +\
                x.streetn + '  slots: ' + x.slots + '  distance: ' + \
                str(int(distance(x, cur))) + 'm  <br>' + closest
        row.append(closest)
        print_table(row)

    else:
        row = []
        for cur in filtrado:
            row.append('Nom: ' + cur.name + "<br>"
                       'Adreça: ' + cur.address + "<br>" +
                       'Districte: ' + cur.district + '<br>' +
                       'Barri: ' + cur.barri + '<br>'
                       'Descripcio: ' + cur.descripcio_curta_pics)
            closenuf = list(
                filter(lambda x: (distance(x, cur) <= 500), stations))
            candidates = list(filter(lambda x: int(x.slots) > 0, closenuf))
            ordered = sorted(candidates, key=(
                lambda x: int(x.slots)), reverse=True)
            ordered = ordered[0:5]
            ordered.reverse()
            closest = ""
            for x in ordered:
                closest = 'ID: ' + x.id + ' street: ' + x.street +\
                    ',' + x.streetn + '  slots: ' + x.slots + '  distance: ' +\
                    str(int(distance(x, cur))) + 'm  <br>' + closest
            row.append(closest)
            candidates = list(filter(lambda x: int(x.bikes) > 0, closenuf))
            ordered = sorted(
                candidates, key=lambda x: int(x.bikes), reverse=True)
            ordered = ordered[0:5]
            ordered.reverse()
            closest = ""
            for x in ordered:
                closest = 'ID: ' + x.id + ' street: ' + x.street + ',' +\
                    x.streetn + '  bicis: ' + x.bikes + '  distance: ' + \
                    str(int(distance(x, cur))) + 'm  <br>' + closest
            row.append(closest)

        print("""<!DOCTYPE html>
        <html>
        <head>
        <meta charset="utf-8">
        <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            width:30%;
        }
        table tr:nth-child(even) {
            background-color: #B2DFDB;
        }
        table tr:nth-child(odd) {
           background-color:#80CBC4;
        }
        </style>
        </head>
        <body>""")

        print_table(row)
