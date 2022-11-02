import 'package:flutter/material.dart';
import 'package:wallpaper_demo/app/di.dart';
import 'package:wallpaper_demo/presentation/resources/color_manager.dart';
import 'package:wallpaper_demo/presentation/search/search_viewmodel.dart';

import '../../domain/model/model.dart';
import '../common/state_renderer/state_renderer_impl.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/value_manager.dart';

class SearchView extends StatefulWidget {
  final String search;
  SearchView({required this.search});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _searchViewController = TextEditingController();
  SearchViewModel _viewModel = instance<SearchViewModel>();
  _bind() {
    _viewModel.setSearch(widget.search);
    _viewModel.start();
    _searchViewController
        .addListener(() => _viewModel.setSearch(_searchViewController.text));
  }

  unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unFocus();
      },
      child: Scaffold(
        backgroundColor: ColorManager.primary,
        appBar: AppBar(
          leading: IconButton(
            splashColor: ColorManager.primary,
            highlightColor: ColorManager.primary,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorManager.white,
            ),
          ),
          elevation: 0,
          backgroundColor: ColorManager.primary,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: Container(
                  height: AppSize.s50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorManager.search,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        AppSize.s30,
                      ),
                    ),
                  ),
                  child: TextField(
                    keyboardAppearance: Brightness.dark,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) {
                      _viewModel.start();
                      _searchViewController.clear();
                    },
                    controller: _searchViewController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            AppSize.s30,
                          ),
                        ),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintText: AppStrings.search,
                      hintStyle: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: AppSize.s18,
                  //     ),
                  //     Expanded(
                  //       child: TextField(
                  //         textInputAction: TextInputAction.search,
                  //         onSubmitted: (_) {
                  //           _viewModel.start();
                  //           _searchViewController.clear();
                  //         },
                  //         controller: _searchViewController,
                  //         decoration: InputDecoration(
                  //           border: InputBorder.none,
                  //           enabledBorder: InputBorder.none,
                  //           focusedBorder: InputBorder.none,
                  //           errorBorder: InputBorder.none,
                  //           hintText: AppStrings.search,
                  //           hintStyle: Theme.of(context).textTheme.subtitle1,
                  //         ),
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         _viewModel.start();
                  //         _searchViewController.clear();
                  //       },
                  //       child: Icon(
                  //         Icons.search,
                  //         color: ColorManager.white,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: AppSize.s18,
                  //     ),
                  //   ],
                  // ),
                ),
              ),
              SizedBox(
                height: AppSize.s40,
              ),
              _searchView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchView() {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(context, _searchData(), () {
              _viewModel.start();
            }) ??
            Container();
      },
    );
  }

  Widget _searchData() {
    return StreamBuilder<List<Source>>(
        stream: _viewModel.outputSearch,
        builder: (context, snapshot) {
          return _searchList(snapshot.data);
        });
  }

  Widget _searchList(List<Source>? search) {
    if (search != null) {
      return Flex(
        direction: Axis.vertical,
        children: [
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: AppSize.s1,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: AppSize.s0_6,
            crossAxisSpacing: AppSize.s1,
            children: List.generate(
              search.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.imageRoute,
                        arguments: search[index].src?.portrait);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppSize.s8)),
                    ),
                    elevation: AppSize.s4,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppSize.s8)),
                      child: Image.network(
                        search[index].src!.portrait,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
