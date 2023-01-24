#ifndef USER_H
#define USER_H

#include <QObject>
#include <QString>
#include <QObject>
#include <QtQml>
#include <iostream>
#include <message.h>
using namespace std;

class User : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit User(QObject *parent = nullptr);
    static User * getInstance();

    Q_INVOKABLE double a_amount();
    Q_INVOKABLE QString u_username();
    Q_INVOKABLE bool s_status();
    Q_INVOKABLE QChar t_type();
    Q_INVOKABLE Message s_sendMessage();
    Q_INVOKABLE Message r_receiveMessage();

    Q_INVOKABLE void set_receiveLoginMessage(Message);
    Q_INVOKABLE void set_receiveRegisterMessage(Message);
    Q_INVOKABLE void set_receiveMessage(Message);



public slots:
    void loginSlot(QString name,QString password);
    void registerSlot(QString name,QString password);
    void transferSlot(QString name,double money);
    void drawAndSaveSlot(double money);
    void checkSlot();

private:
    Message sendMessage;
    Message receiveMessage;
    QString userName;
    double amount=0;
    bool status=false;
    char type='6';

signals:

};

#endif // USER_H
