import 'package:flutter/material.dart';
import 'package:wallpaper_demo/app/di.dart';
import 'package:wallpaper_demo/domain/model/model.dart';
import 'package:wallpaper_demo/presentation/home/home_viewmodel.dart';
import 'package:wallpaper_demo/presentation/resources/color_manager.dart';
import 'package:wallpaper_demo/presentation/resources/value_manager.dart';
import 'package:wallpaper_demo/presentation/resources/assets_manager.dart';
import '../common/state_renderer/state_renderer_impl.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeViewModel _viewModel = instance<HomeViewModel>();
  @override
  void initState() {
    _viewModel.start();
    searchController
        .addListener(() => _viewModel.setSearch(searchController.text));
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  List<Category> categoryList = [
    Category(image: ImageAssets.streetArt, title: AppStrings.streetArt),
    Category(image: ImageAssets.wildlife, title: AppStrings.wildLife),
    Category(image: ImageAssets.nature, title: AppStrings.nature),
    Category(image: ImageAssets.people, title: AppStrings.people),
    Category(image: ImageAssets.sport, title: AppStrings.sport),
    Category(image: ImageAssets.health, title: AppStrings.health),
    Category(image: ImageAssets.event, title: AppStrings.event),
    Category(image: ImageAssets.lifestyle, title: AppStrings.lifestyle),
  ];

  unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unFocus();
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              width: AppSize.s18,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: StreamBuilder<bool>(
                  stream: _viewModel.outPutSearchValid,
                  builder: (context, snapshot) {
                    return TextField(
                      cursorColor: ColorManager.lightGrey,
                      keyboardAppearance: Brightness.dark,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) {
                        if (snapshot.data ?? false) {
                          Navigator.pushNamed(context, Routes.searchRoute,
                              arguments: searchController.text);

                          searchController.clear();
                        }
                      },
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(
                              AppSize.s8,
                            ))),
                        // errorText: (snapshot.d)
                        //     ? null
                        //     : AppStrings.error,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        hintText: AppStrings.search,
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: AppSize.s40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
              child: SizedBox(
                height: AppSize.s50,
                child: ListView.builder(
                  itemCount: categoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryContainer(
                        category: categoryList[index],
                        press: () {
                          Navigator.pushNamed(context, Routes.categoryRoute,
                              arguments: categoryList[index].title);
                        });
                  },
                ),
              ),
            ),
            SizedBox(
              height: AppSize.s20,
            ),
            _gridView(),
          ],
        ),
      ),
    );
  }

  Widget _gridView() {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(context, _gridData(), () {
              _viewModel.start();
            }) ??
            Container();
      },
    );
  }

  Widget _gridData() {
    return StreamBuilder<List<Source>>(
        stream: _viewModel.outputGridData,
        builder: (context, snapshot) {
          return _gridList(snapshot.data);
        });
  }

  Widget _gridList(List<Source>? grid) {
    if (grid != null) {
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
              grid.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.imageRoute,
                        arguments: grid[index].src?.portrait);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppSize.s8)),
                    ),
                    elevation: AppSize.s4,
                    child: Hero(
                      tag: grid[index].src!.portrait,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s8)),
                        child: Image.network(
                          grid[index].src!.portrait,
                          fit: BoxFit.cover,
                        ),
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

class CategoryContainer extends StatelessWidget {
  Category category;
  Function press;
  CategoryContainer({required this.category, required this.press});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: AppPadding.p10),
      child: GestureDetector(
        onTap: () => press(),
        child: Container(
          height: AppSize.s50,
          width: AppSize.s100,
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppSize.s12,
              ),
            ),
            image: DecorationImage(
                image: AssetImage(category.image), fit: BoxFit.cover),
          ),
          child: Center(
            child: Text(
              category.title,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
      ),
    );
  }
}
