
import QtQuick 2.0
import QtQuick.Window 2.0
import QtLocation 5.11
import QtPositioning 5.11

Window {
    width: 812
    height: 512
    visible: true

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    ListModel {
        id: markerModel
        property int elementId : 0
        property int indexToRemove : -1
        function removeElement_real() {
            for (var i = 0; i < markerModel.count; i++)
                if (markerModel.get(i).idx === indexToRemove) {
                    markerModel.remove(i)
                    break
                }
        }

        function removeElement(idx) {
            markerModel.indexToRemove = idx
            deleteTimer.start()
        }

        function updatePolygon() {
            if (markerModel.count < 3)
                polygon.visible = false
            else
                polygon.visible = true
            var path = []
            for (var i = 0; i < markerModel.count; i++) {
                var elem = markerModel.get(i)
                var crd = QtPositioning.coordinate(elem.varLatitude, elem.varLongitude)
                path.push(crd)
            }
            polygon.path = path
        }

        onCountChanged: updatePolygon()
    }

    Map {

        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(43.0, 13.0) // coordinate iniziali
        zoomLevel: 8
        z: 100


        MapPolygon {
            id: poly
            opacity: 0.4
            border.width : 1.5
            border.color: 'black'
            color: 'red'
            visible: true
            path: [
                { latitude: 43.5, longitude: 13.5 },
                { latitude: 42.5, longitude: 13.5 },
                { latitude: 42.5, longitude: 12.5 },
                { latitude: 43.5, longitude: 12.5 }

            ]

        }

        MouseArea {
            anchors.fill: parent
            onPressAndHold: {
                var point = Qt.point(mouseX, mouseY)
                var co = map.toCoordinate(point)
                poly.addCoordinate(co)


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
    }

}
