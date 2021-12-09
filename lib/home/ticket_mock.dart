class TicketMock {
  final String address;
  final String title;
  final String description;

  TicketMock(
    this.address,
    this.title,
    this.description,
  );
}

final ticketsMock = [
  ['Адрес здания', 'Тема заявки', 'Описание'],
  ['address2', 'title2', 'description2'],
  ['address3', 'title3', 'description3'],
]
    .map(
      (e) => TicketMock(e[0], e[1], e[2]),
    )
    .toList();
