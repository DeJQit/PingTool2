#ifndef SPROCESS_H
#define SPROCESS_H

#include <QProcess>


class SProcess : public QProcess
{
    Q_OBJECT
public:
    SProcess(QObject *parent = nullptr);

public slots:
    void start(const QString &program, const QVariantList &arguments);

    void kill();

    QByteArray readAll();
};

#endif // SPROCESS_H
