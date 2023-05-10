import 'package:flutter/material.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../data/network/model/ticket.dart';

const String _qrCode = "QR Code";
const String _qrCodTitle = "Tickets";

class QrCodeButton extends StatelessWidget {
  final List<Ticket> tickets;

  const QrCodeButton({
    super.key,
    required this.tickets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              QrCodeAlertDialog(tickets: tickets),
        ),
        child: const QrCodeButtonContent(),
      ),
    );
  }
}

class QrCodeAlertDialog extends StatelessWidget {
  final List<Ticket> tickets;

  const QrCodeAlertDialog({
    super.key,
    required this.tickets,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(_qrCodTitle),
      content: SizedBox(
        width: 400,
        height: 300,
        child: ListView(
          children: [
            Column(
              children: [
                ...tickets
                    .map((entry) => QRCodeItem(
                  data: entry.id.toString(),
                ))
                    .toList(),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class QrCodeButtonContent extends StatelessWidget {
  const QrCodeButtonContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          _qrCode,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          width: 10.0,
        ),
        Icon(
          Icons.qr_code,
          color: Theme.of(context).colorScheme.onSurface,
          size: 24.0,
        ),
      ],
    );
  }
}

class QRCodeItem extends StatelessWidget {
  final String data;

  const QRCodeItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: QrImage(
        data: data,
        backgroundColor: Colors.white,
        version: QrVersions.auto,
        size: 150.0,
      ),
    );
  }
}
