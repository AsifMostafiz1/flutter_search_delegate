import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_delecate/details_page.dart';
import 'package:flutter_search_delecate/product_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ProductSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query.isEmpty? close(context,'') :query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context,) {
    return Center(child: Text(query),);
  }

  @override

  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? productLists
        : productLists
            .where((element) =>
                element.title.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return suggestionList.isEmpty?const Center(child: Text("No Product Found"),) :ListView.builder(
      itemBuilder: (context, index) {
        final product = suggestionList[index];


        return GestureDetector(
          onTap: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>DetailsPage(product.title,product.imageUrl,product.description)));
          },
          child: Card(

            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(
                        product.title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
