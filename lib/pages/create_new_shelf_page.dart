import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/create_new_shelf_bloc.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';

class CreateNewShelfPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateNewShelfBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: MARGIN_MEDIUM_2),
              Container(
                margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                child: Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      _createNewShelf(context, _controller.text);
                    },
                    child: const Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                  );
                }),
              ),
              const SizedBox(height: MARGIN_LARGE),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
                child: Builder(builder: (context) {
                  return TextField(
                    controller: _controller,
                    autofocus: true,
                    decoration: const InputDecoration(
                        hintText: SHELF_NAME,
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        )),
                    style: const TextStyle(
                      fontSize: TEXT_HEADING_1X,
                      fontWeight: FontWeight.w500,
                    ),
                    onSubmitted: (name) => _createNewShelf(context, name),
                  );
                }),
              ),
              const SizedBox(height: MARGIN_LARGE),
              const Divider(
                color: Colors.black54,
                height: MARGIN_LARGE,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createNewShelf(BuildContext context, String shelfName) {
    if (shelfName.isNotEmpty) {
      CreateNewShelfBloc bloc = Provider.of(context, listen: false);
      bloc.createNewShelf(shelfName);
      Navigator.pop(context);
    } else {
      showShelfNameEmptyWarningSheet(context);
    }
  }

  void showShelfNameEmptyWarningSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
              title: Text(
                COULD_NOT_CREATE_THIS_SHELF,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: TEXT_CARD_REGULAR_2X,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.black12,
            ),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
              title: Text(
                ENTER_A_SHELF_NAME,
                style: TextStyle(fontSize: TEXT_REGULAR, color: Colors.black54),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: MARGIN_LARGE,
                right: MARGIN_LARGE,
                bottom: MARGIN_LARGE,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(OK),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
