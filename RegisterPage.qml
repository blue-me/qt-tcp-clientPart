import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.3
import "./MyQmlObject"
Rectangle {
    width: parent.width
    height: parent.height

    MyMessageDialog {
        id: passwordNotSame
        text: "两次密码不一样"
        onYes: close()
    }
    MyMessageDialog {
        id: accountExist
        text: "此账户已存在"
        onYes: close()
    }
    MyMessageDialog {
        id: networkWrong
        text: "网络出错"
        onYes: close()
    }
    MyMessageDialog {
        id: registerSuccess
        text: "注册成功"
        onYes: {
            close()
            myStackView.pop()
        }
    }

    Row{
        spacing:10
        x:10
        y:10

        Text{
            text:"你的用户名:"
            font.pointSize: 15
        }

        MyInputRectangle{
            MyTextInput{
                id:registerUsernameInput
            }
        }
    }

    Row{
        spacing:10
        x:10
        y:50

        Text{
            text:"你的密码:"
            font.pointSize: 15
        }

        MyInputRectangle{
            MyTextInput{
                id:registerUserpasswordInput
            }
        }
    }

    Row{
        spacing:10
        x:10
        y:90

        Text{
            text:"确认你的密码:"
            font.pointSize: 15
        }

        MyInputRectangle{
            MyTextInput{
                id:sureUserpasswordInput
            }
        }
    }

    signal registerSig(string name,string password)

    Button {
        id:registerPageSureButton
        text: "确认"
        x:100
        y:200

        style:MyButtonStyle{}

        onClicked: {
            //var str1 = String(registerUserpasswordInput.text)
            //var str2 = String(sureUserpasswordInput.text)
            //console.log(str1==str2)
            if(registerUserpasswordInput.text===sureUserpasswordInput.text)
            {
                console.log("Password same!")
                //console.log(str1==str2)
                if(client.connect())
                {
                    registerSig(registerUsernameInput.text,sureUserpasswordInput.text)
                    client.send(user.s_sendMessage())
                    user.set_receiveRegisterMessage(client.receive())
                    if(user.t_type()=== '5'){
                        client.disconnect()
                        accountExist.open();
                    }
                    else{
                        client.disconnect()
                        registerSuccess.open()

                    }
                }
                else
                    networkWrong.open();
            }
            else{
                passwordNotSame.open()
            }

        }
    }

    Connections{
        target:registerPage.item
        function onRegisterSig(name,password){
            user.registerSlot(name,password)
            console.log("send registerSig")
        }
    }

    Button {
        text: "取消"
        x:200
        y:200

        style:MyButtonStyle{}

        onClicked: myStackView.pop() // back to mainPage
    }
}
