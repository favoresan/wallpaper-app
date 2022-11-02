import 'package:flutter/material.dart';
import 'package:wallpaper_demo/app/di.dart';
import 'package:wallpaper_demo/presentation/category/category_viewmodel.dart';

import '../../domain/model/model.dart';
import '../common/state_renderer/state_renderer_impl.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/value_manager.dart';

class CategoryView extends StatefulWidget {
  final String categorySearch;
  CategoryView({required this.categorySearch});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  CategoryViewModel _viewModel = instance<CategoryViewModel>();

  @override
  void initState() {
    _viewModel.setSearch(widget.categorySearch);
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        title: Text(
          widget.categorySearch,
          style: Theme.of(context).textTheme.headline2,
        ),
        leading: IconButton(
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
            _categoryView(),
          ],
        ),
      ),
    );
  }

  Widget _categoryView() {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(context, _categoryData(), () {
              _viewModel.start();
            }) ??
            Container();
      },
    );
  }

  Widget _categoryData() {
    return StreamBuilder<List<Source>>(
        stream: _viewModel.outputCategorySearch,
        builder: (context, snapshot) {
          return _categoryList(snapshot.data);
        });
  }

  Widget _categoryList(List<Source>? search) {
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
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSize.s8),
                      ),
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
