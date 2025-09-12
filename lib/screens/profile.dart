 // ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool autoShare = true;
  String lang = 'AZ';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profil məlumatları
          Row(
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Məhəmməd',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'test@mail.com',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Lokasiya: Bakı',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // AI Auto-Share ayarı
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: SwitchListTile(
              title: const Text('AI Auto-Share'),
              subtitle: const Text('Sərfiyyat artdıqda avtomatik paylaşım'),
              value: autoShare,
              onChanged: (v) => setState(() => autoShare = v),
            ),
          ),
          const SizedBox(height: 12),

          // Dil seçimi
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Dil seçimi'),
              trailing: DropdownButton<String>(
                value: lang,
                underline: const SizedBox(),
                onChanged: (v) => setState(() => lang = v!),
                items: const [
                  DropdownMenuItem(value: 'AZ', child: Text('AZ')),
                  DropdownMenuItem(value: 'EN', child: Text('EN')),
                ],
              ),
            ),
          ),

          const Spacer(),

          // Çıxış düyməsi
          Center(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                'Çıxış',
                style: TextStyle(color: Colors.red),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Çıxış'),
                  content: const Text(
                      'Hesabdan çıxmaq istədiyinizə əminsiniz?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('İmtina'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Çıxış edildi (demo)'),
                          ),
                        );
                      },
                      child: const Text(
                        'Çıxış',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
