import 'package:daily_workout/components/app_bar_component.dart';
import 'package:daily_workout/database/dao/exercicio_finalizado_dao.dart';
import 'package:daily_workout/database/dao/treino_finalizado_dao.dart';
import 'package:daily_workout/screens/calendar/card_item_treino_finalizado.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../components/bottom_navigation_calendar.dart';
import '../../models/Treino_finalizado.dart';

// ignore: must_be_immutable
class Calendar extends StatefulWidget {
  Calendar({Key? key}) : super(key: key);
  List<TreinoFinalizado> _treinos = [];

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final TreinoFinalizadoDao _treinoFinalizadoDao = TreinoFinalizadoDao();
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  void callback(ExercicioFinalizadoDao _exercicioDao, TreinoFinalizadoDao _treinoDao, int id) {
    setState(() {
      _exercicioDao.deletePorTreino(id);
      _treinoDao.delete(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(
          title: "Calendário", color: 0xFF22272B, barHeight: 70, fontSizes: 30, image: Image.asset('images/logo_pequena_40')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TableCalendar(
                onDaySelected: (selectDay, focusDay) async {
                  final List<TreinoFinalizado> treinos =
                      await _treinoFinalizadoDao.findAllBydata(DateFormat('dd/MM/yyyy', 'pt_BR').format(focusDay).toString());
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                    widget._treinos = treinos;
                  });
                },
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(color: Color(0xFFFDEBAF), shape: BoxShape.circle),
                  selectedTextStyle: TextStyle(color: Colors.black),
                ),
                selectedDayPredicate: (date) {
                  return isSameDay(selectedDay, date);
                },
                onPageChanged: (focusDay) {
                  focusedDay = focusDay;
                },
                locale: 'pt_Br',
                focusedDay: focusedDay,
                firstDay: DateTime.utc(2010, 10, 20),
                lastDay: DateTime.utc(2040, 10, 20),
                headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
              ),
              ListView.builder(
                itemCount: widget._treinos.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, indice) {
                  return ItemTreinoFinalizado(widget._treinos[indice], callback);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationCalendar(),
    );
  }
}
