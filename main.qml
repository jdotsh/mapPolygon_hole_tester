
import QtQuick 2.0
import QtQuick.Window 2.0
import QtLocation 5.11
import QtPositioning 5.11

Window {
    width: 1024
    height: 1024
    visible: true

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(44.0, 12.5) // coordinate iniziali
        zoomLevel: 8
        z: 100

        QGeoRectangle{
        }

        MapPolygon {
            id: foo
            opacity: 0.4
            border.width : 1.5
            border.color: 'black'
            color: 'red'
            visible: true
        }

        MapPolyline{
            id: foo2
            opacity: 0.4
            line.width : 1.5
            line.color: 'black'
            visible: true
            path : [QtPositioning.coordinate( 45.0, 15.0),
                    QtPositioning.coordinate( 43.0, 15.0)
                   ]
        }

        /*
        MouseArea {
            anchors.fill: parent
            onPressAndHold: {
                var point = Qt.point(mouseX, mouseY)
                var co = map.toCoordinate(point)
                var coords = [ QtPositioning.coordinate( 10, -10), // main polygon
                              QtPositioning.coordinate( 10,  10),
                              QtPositioning.coordinate(-10,  10),
                              QtPositioning.coordinate(-10, -10),
                              QtPositioning.coordinate(10, -10)]
                var poly = QtPositioning.polygon(coords)


            }

            onDoubleClicked: {

                var holecoord = [QtPositioning.coordinate(43.25,13.25),
                                 QtPositioning.coordinate(42.75,13.25),
                                 QtPositioning.coordinate(42.75,12.75),
                                 QtPositioning.coordinate(43.25,12.75)
                        ]

                poly.addHole(holecoord)
                var extractedHole = poly.hole(0)

                console.log("Hole no. 1:"+ poly.hole(0))
                console.log("Holes in polygon:"+poly.holesCount())

            }


        }
*/
        Component.onCompleted: {

            console.log("Executing")
            var coords = [ QtPositioning.coordinate( 45.0, 11.0), // main polygon
                          QtPositioning.coordinate( 45.0, 14.0),
                          QtPositioning.coordinate( 43.0, 14.0),
                          QtPositioning.coordinate( 43.0, 11.0),
                          QtPositioning.coordinate( 45.0, 11.0)]

            var hole0 = [ QtPositioning.coordinate(44.0, 13.0),
                         QtPositioning.coordinate(44.0, 13.5),
                         QtPositioning.coordinate(43.2, 13.5),
                         QtPositioning.coordinate(43.2, 13),
                         QtPositioning.coordinate(44, 13)]

            var hole1 = [  QtPositioning.coordinate(
                             44.50568032330811,11.339800357818602

                           ),
                           QtPositioning.coordinate(
                             44.499275580982854,11.327011585235596

                           ),
                           QtPositioning.coordinate(
                             44.49027561444014,11.329618692398071

                           ),
                           QtPositioning.coordinate(
                             44.48641806072098,11.339542865753174

                           ),
                           QtPositioning.coordinate(
                             44.48444326187773,11.356236934661865

                           ),
                           QtPositioning.coordinate(
                             44.485729184996416,11.357996463775635

                           ),
                           QtPositioning.coordinate(
                             44.498204229229955,11.356655359268188

                           ),
                           QtPositioning.coordinate(
                             44.5009514417433,11.356226205825806

                           ),
                           QtPositioning.coordinate(
                             44.50227526116511,11.352717876434326

                           ),
                           QtPositioning.coordinate(
                             44.504111723881955,11.348243951797485

                           ),
                           QtPositioning.coordinate(
                             44.50475447216561,11.345518827438354

                           ),
                           QtPositioning.coordinate(
                             44.50568032330811,11.339800357818602

                           )]



            var poly = QtPositioning.polygon(coords)

            poly.addHole(hole0)
            poly.addHole(hole1)

            foo.setGeoPolygon(poly)

            console.log("1st test: " + poly.holesCount())
            /*


            var hole1 = [ QtPositioning.coordinate(6, -6),
                         QtPositioning.coordinate( 7, -6),
                         QtPositioning.coordinate(7, -7),
                         QtPositioning.coordinate(6, -7),
                         QtPositioning.coordinate(6, -6)]

            var hole2 = [ QtPositioning.coordinate(6, 6),
                         QtPositioning.coordinate(7, 6),
                         QtPositioning.coordinate(7, 7),
                         QtPositioning.coordinate(6, 7),
                         QtPositioning.coordinate(6, 6)]




            poly.addHole(hole1)
            poly.addHole(hole2)
            // using the setter to store holes data


            // correctly returns:
            // "qml: 3"

            var firstHole = poly.hole(0)
            //using the getter to extract an hole

            console.log("using the getter to extract the first hole: " + firstHole)
            // correctly returns:
            // "qml: [6° 0' 0.0" N, 6° 0' 0.0" W,7° 0' 0.0" N, 6° 0' 0.0" W,7° 0' 0.0" N, 7° 0' 0.0" W,6° 0' 0.0" N, 7° 0' 0.0" W,6° 0' 0.0" N, 6° 0' 0.0" W]"

            console.log("Point in hole0, should return false: " + poly.contains(QtPositioning.coordinate(0,0)))
            console.log("Point on hole0 boundary, should return true: " + poly.contains(QtPositioning.coordinate(5,0)))
            console.log("Point in hole1, should return false: " + poly.contains(QtPositioning.coordinate(6.5,-6.5)))
            console.log("Point on hole1 boundary, should return true: " + poly.contains(QtPositioning.coordinate(6.5,-6)))
            console.log("Point in hole2, should return false: " + poly.contains(QtPositioning.coordinate(6.5,6.5)))
            console.log("Point on hole2 boundary, should return true: " + poly.contains(QtPositioning.coordinate(6.5,6)))
            console.log("hole count test: "+poly.holesCount())
            // uncorrectly returns true.
            // it seems that contains method doesn't recognize holes loaded from QML
            // on the same polygon, the contains method works as expected in C++
            // now re-thinking the whole implementation

            console.log("Point outside polygon, should return false: " + poly.contains(QtPositioning.coordinate(20,20)))
            console.log("Point on polygon boundary, should return true: " + poly.contains(QtPositioning.coordinate(10,0)))
            console.log("Point in polygon, not in hole, should return true: " + poly.contains(QtPositioning.coordinate(8,8))) */
        }
    }

}

