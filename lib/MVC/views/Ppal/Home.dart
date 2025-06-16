import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handheld_beta/MVC/Views/GestionGalvanizado/TrasladoB11B2.dart';
import 'package:handheld_beta/MVC/Views/GestionGalvanizado/TrasladoB2B11.dart';
import 'package:handheld_beta/core/constants/FrontEnd.dart';
import 'package:handheld_beta/core/utils/Svg_Icons.dart';
import '../GestionAlambron/DescargueAlambron.dart';
import '../GestionAlambron/TrasladoB1b2.dart';
import '../GestionAlambron/TrasladoB2b1.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PROCESS MANAGMENT"),
        centerTitle: true,
      ),
      body: ListView(
        padding: FrontEnd.defaultPadding,
        children: [
          _buildSection(
            context,
            icon: 'alambron',
            title: 'ALAMBRON',
            items: [
              _buildListTile(context,
                  icon: Icons.move_down_rounded,
                  title: 'Transfer to the Winery (1-2)',
                  page: const TrasladoB1b2View()),
              _buildListTile(context,
                  icon: Icons.move_up_rounded,
                  title: 'Transfer to the Winery (2-1)',
                  page: const TrasladoB2b1View()),
              _buildListTile(context,
                  icon: Icons.paste_sharp,
                  title: 'Download Alambron',
                  page: const DescargueAlambron()),
            ],
          ),
          _buildSection(
            context,
            icon: 'galva',
            title: 'GALVANIZED',
            items: [
              _buildListTile(context,
                  icon: Icons.move_down_rounded,
                  title: 'Transfer to the Winery (2-11)',
                  page: Trasladob2b11View()),
              _buildListTile(context,
                  icon: Icons.move_up_rounded,
                  title: 'Transfer to the Winery (11-2)',
                  page: Trasladob11b2View()),
            ],
          ),
          _buildSection(
            context,
            icon: 'menuSpikes',
            title: 'SPIKES',
            items: [
              _buildListTile(context,
                  icon: Icons.forklift, title: 'Delivery of Raw Materials')
            ],
          ),
          _buildSection(
            context,
            icon: 'clavo',
            title: 'LACEWORK',
            items: [
              _buildListTile(
                context,
                icon: Icons.forklift,
                title: 'Delivery of Raw Materials',
              ),
              _buildListTile(
                context,
                icon: Icons.trolley,
                title: 'Distribution',
              ),
              _buildListTile(
                context,
                icon: Icons.swap_horizontal_circle_outlined,
                title: 'Returns',
              ),
            ],
          ),
          _buildSection(
            context,
            icon: 'clavo',
            title: 'SCREWS',
            items: [
              _buildListTile(
                context,
                icon: Icons.forklift,
                title: 'Delivery of Raw Materials',
              ),
              _buildListTile(
                context,
                icon: Icons.trolley,
                title: 'Distribution',
              ),
              _buildListTile(
                context,
                icon: Icons.swap_horizontal_circle_outlined,
                title: 'Returns',
              ),
            ],
          ),
          _buildSection(
            context,
            icon: 'calidad',
            title: 'REVIEW - QUALITY',
            items: [
              _buildListTile(
                context,
                icon: Icons.tire_repair_outlined,
                title: 'Galvanized',
              ),
              _buildListTile(
                context,
                icon: Icons.tonality_rounded,
                title: 'Wire drawing (Bright and Special)',
              ),
              _buildListTile(
                context,
                icon: Icons.tornado_rounded,
                title: 'Industrial Annealing',
              ),
              _buildListTile(
                context,
                icon: Icons.tornado_outlined,
                title: 'Annealed Construction',
              ),
              _buildListTile(
                context,
                icon: Icons.upcoming_outlined,
                title: 'Galvanized Sampling',
              ),
              _buildListTile(
                context,
                icon: Icons.upcoming_outlined,
                title: 'Rejection Review',
              ),
            ],
          ),
          _buildSection(
            context,
            icon: 'entrega',
            title: 'LOGISTICS - RECEPTION',
            items: [
              _buildListTile(
                context,
                icon: Icons.tire_repair_outlined,
                title: 'Galvanized',
              ),
              _buildListTile(
                context,
                icon: Icons.tonality_rounded,
                title: 'Wire drawing (Bright and Special)',
              ),
              _buildListTile(
                context,
                icon: Icons.tornado_outlined,
                title: 'Annealed Construction',
              ),
              _buildListTile(
                context,
                icon: Icons.auto_graph_rounded,
                title: 'Spikes',
              ),
              _buildListTile(
                context,
                icon: Icons.data_thresholding_sharp,
                title: 'Logistics Audit',
              ),
            ],
          ),
          _buildSection(
            context,
            icon: 'otro',
            title: 'OTHERS',
            items: [
              _buildListTile(
                context,
                icon: Icons.inventory_sharp,
                title: 'Inventory',
              ),
              _buildListTile(
                context,
                icon: Icons.currency_lira_outlined,
                title: 'Consumption SCAL',
              ),
              _buildListTile(
                context,
                icon: Icons.currency_pound,
                title: 'Consumption SCAE',
              ),
              _buildListTile(
                context,
                icon: Icons.currency_rupee,
                title: 'Consumption SAR',
              ),
              _buildListTile(
                context,
                icon: Icons.currency_yen_sharp,
                title: 'Consumption SAV',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String icon,
      required String title,
      required List<Widget> items}) {
    return Column(
      children: [
        FrontEnd.mediumSpacer,
        _buildExpansionTile(
          context,
          icon: icon,
          title: title,
          items: items,
        ),
      ],
    );
  }

  Widget _buildExpansionTile(BuildContext context,
      {required String icon,
      required String title,
      required List<Widget> items}) {
    return ExpansionTile(
      leading: SvgIcons.icon(icon, context: context),
      title: Text(title),
      children: [
        ...items,
      ],
    );
  }

  Widget _buildListTile(BuildContext context,
      {required IconData icon, required String title, Widget? page}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: page != null
          ? () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              )
          : null,
    );
  }
}
