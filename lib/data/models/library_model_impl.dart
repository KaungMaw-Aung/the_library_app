import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/network/data_agents/library_data_agent.dart';
import 'package:the_library_app/network/data_agents/library_data_agent_retrofit_impl.dart';

class LibraryModelImpl extends LibraryModel {

  static final LibraryModelImpl _singleton = LibraryModelImpl._internal();

  factory LibraryModelImpl() => _singleton;

  LibraryModelImpl._internal();

  /// Data Agents
  final LibraryDataAgent _dataAgent = LibraryDataAgentRetrofitImpl();

  @override
  Future<List<BookOverviewListVO>?> getBookOverviewLists() {
    return _dataAgent.getBookOverviewLists();
  }

}