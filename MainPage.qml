import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQml 2.12
import QtQuick.Layouts 1.15
import userExample 1.0

Rectangle {
    width:parent.width
    height:parent.height

    Label{
        text:"Your account: "+user.u_username()
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    }

    Button {
        id:saveButton
        x:50
        y:50
        style: ButtonStyle{
            label:Text{
                font.pointSize: 20
                text: "存储"
            }
        }

        onClicked: myLoader.sourceComponent = savePage // 切换显示登录页面
    }

    Button {
        id:transferButton

        x:50
        y:150
        style: ButtonStyle{
            label:Text{
                font.pointSize: 20
                text: "汇款"
            }
        }
        onClicked: myLoader.sourceComponent = transferPage // 切换显示登录页面
    }

    signal checkSig()
    Button {
        id:checkButton

        x:50
        y:250
        style: ButtonStyle{
            label:Text{
                font.pointSize: 20
                text: "查询"
            }
        }
        onClicked:{
            checkSig()
            client.send(user.s_sendMessage())
            console.log("client send OK")
            user.set_receiveMessage(client.receive())
            if(user.t_type() === '6'){
                networkWrong.open();
            }
            else{
                 myLoader.sourceComponent = checkPage // 切换显示登录页面
            }
        }
    }
    Connections{
        target:myLoader.item
        function onCheckSig(){
            user.checkSlot()
        }
    }

    Button {
        id:exitButton

        x:50
        y:350
        style: ButtonStyle{
            label:Text{
                font.pointSize: 20
                text: "退出"
            }
        }
        onClicked:{
          client.disconnect()
          myLoader.sourceComponent = loginPage // 切换显示登录页面
        }
    }

    Button {
        id:drawButton

        x:50
        y:450
        style: ButtonStyle{
            label:Text{
                font.pointSize: 20
                text: "取款"
            }
        }
        onClicked: myLoader.sourceComponent = drawPage // 切换显示登录页面
    }
}



