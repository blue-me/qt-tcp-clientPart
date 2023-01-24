#ifndef MESSAGE_H
#define MESSAGE_H
#include <QMetaType>

using namespace std;
typedef struct {

    char info_name[16];
    char info_password[16];
    double number;
    bool status;
    char type;
}Message;

Q_DECLARE_METATYPE(Message)

#endif // MESSAGE_H

