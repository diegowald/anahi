#ifndef CLUBESMODEL_H
#define CLUBESMODEL_H

#include <QAbstractListModel>

class ClubesModel : public QAbstractListModel
{
    Q_OBJECT
public:

    enum ClubRole {
        FullNameRole = Qt::DisplayRole,
        AddressRole = Qt::UserRole,
        CityRole,
        LogoRole,
        CategoriaRole,
        TypeRole
    };
    Q_ENUM(ClubRole)

    enum ClubType {
        Map,
        Telephone,
        WhatsApp,
        Web
    };
    Q_ENUM(ClubType)

public:
    explicit ClubesModel(QObject *parent = nullptr);
    virtual ~ClubesModel() {}

    int rowCount(const QModelIndex & = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE void append(const QString &fullName, const QString &address, const QString  &city, const QString &number);
    Q_INVOKABLE void set(int row, const QString &fullName, const QString &address, const QString  &city, const QString &number);
    Q_INVOKABLE void remove(int row);

private:
    struct Club {
        QString fullName;
        QString address;
        QString city;
        QString logo;
        QString categoria;
        ClubType tipo;
    };

    QList<Club> m_club;
};

#endif // CLUBESMODEL_H
