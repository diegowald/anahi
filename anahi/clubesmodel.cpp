#include "clubesmodel.h"

ClubesModel::ClubesModel(QObject *parent) : QAbstractListModel(parent)
{
    m_club.append({ "Club Argentino", "", "Bahía Blanca", "qrc:///clubes/clubArgentino.png", "Rugby", ClubType::Web });
    m_club.append({ "Sociedad Sportiva", "", "Bahía Blanca", "qrc:///clubes/clubSportiva.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Palihue Rugby y Hockey", "", "Bahía Blanca", "qrc:///clubes/ClubPalihue.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Club Universitario", "", "Bahía Blanca", "qrc:///clubes/clubUniversitario.jpg", "Rugby", ClubType::Web });
    m_club.append({ "El Nacional", "", "Bahía Blanca", "qrc:///clubes/clubElNacional.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Puerto Belgrano", "", "Puerto Belgrano", "qrc:///clubes/clubPuertoBelgrano.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Santa Rosa RC", "", "Santa Rosa", "qrc:///clubes/clubSantaRosa.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Punta Alta RC", "", "Punta Alta", "qrc:///clubes/clubPuntaAlta.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Villa Mitre", "", "Bahía Blanca", "qrc:///clubes/ClubVillaMitre.png", "Rugby", ClubType::Web });
    m_club.append({ "Coronel Pringles", "", "Coronel Pringles", "qrc:///clubes/clubPuertoBelgrano.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Coronel Suarez", "", "Coronel Suarez", "qrc:///clubes/clubCoronelSuarez.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Halcones", "", "Darregueira", "qrc:///clubes/halcones.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Camarones", "", "Pinamar", "qrc:///clubes/ClubCamarones.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Los 50", "", "Tandil" , "qrc:///clubes/ClubLos50.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Draig Goch", "", "Gaiman", "qrc:///clubes/clubDraigGroch.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Bigornia", "", "Rawson", "qrc:///clubes/clubBigornia.png", "Rugby", ClubType::Web });
    m_club.append({ "Centro Naval", "", "Bahía Blanca", "qrc:///clubes/ClubCentroNaval.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Club Náutico Necochea", "", "Necochea", "qrc:///clubes/ClubNecochea.jpg", "Rugby", ClubType::Web });
    m_club.append({ "Independiente", "", "Puan", "qrc:///clubes/clubIndependientePuan.jpg", "Rugby", ClubType::Web });
}

int ClubesModel::rowCount(const QModelIndex &) const
{
    return m_club.count();
}

QVariant ClubesModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < rowCount())
        switch (role) {
        case FullNameRole: return m_club.at(index.row()).fullName;
        case AddressRole: return m_club.at(index.row()).address;
        case CityRole: return m_club.at(index.row()).city;
        case LogoRole: return m_club.at(index.row()).logo;
        case CategoriaRole: return m_club.at(index.row()).categoria;
        case TypeRole: return m_club.at(index.row()).tipo;
        default: return QVariant();
    }
    return QVariant();
}

QHash<int, QByteArray> ClubesModel::roleNames() const
{
    static const QHash<int, QByteArray> roles {
        { FullNameRole, "fullName" },
        { AddressRole, "address" },
        { CityRole, "city" },
        { LogoRole, "logo" },
        { CategoriaRole, "categoria"},
        { TypeRole, "tipo"}
    };
    return roles;
}

QVariantMap ClubesModel::get(int row) const
{
    const Club contact = m_club.value(row);
    return { {"fullName", contact.fullName}, {"address", contact.address}, {"city", contact.city}, {"logo", contact.logo} };
}

void ClubesModel::append(const QString &fullName, const QString &address, const QString &city, const QString &number)
{
    int row = 0;
    while (row < m_club.count() && fullName > m_club.at(row).fullName)
        ++row;
    beginInsertRows(QModelIndex(), row, row);
    m_club.insert(row, {fullName, address, city, number, "categoria"});
    endInsertRows();
}

void ClubesModel::set(int row, const QString &fullName, const QString &address, const QString &city, const QString &number)
{
    if (row < 0 || row >= m_club.count())
        return;

    m_club.replace(row, { fullName, address, city, number, "categpria" });
    dataChanged(index(row, 0), index(row, 0), { FullNameRole, AddressRole, CityRole, LogoRole });
}

void ClubesModel::remove(int row)
{
    if (row < 0 || row >= m_club.count())
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_club.removeAt(row);
    endRemoveRows();
}
