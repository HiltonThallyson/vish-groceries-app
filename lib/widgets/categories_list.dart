import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../data/categories.dart';
import 'category_item.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryFilter = context.read<ProductsProvider>();
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Categorias",
              style: TextStyle(
                  fontSize: 24, color: Colors.black, fontFamily: "Acme"),
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/categorias'),
                child: Text("Mostrar todas",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ))),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: SizedBox(
          width: 400,
          height: 100,
          child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  ),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: ((context, index) => InkWell(
                    child: CategoryItem(categories[index]),
                    onTap: () => categoryFilter
                        .changeCategoryFilter(categories[index].id),
                  ))),
        ),
      ),
    ]);
  }
}
