import 'package:auth_generator/constants/xml_constants.dart';
import 'package:auth_generator/view_models/generator_view_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class GeneratorView extends StatelessWidget {
  const GeneratorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GeneratorViewModel>(
      create: (BuildContext context) => GeneratorViewModel(),
      child: Consumer<GeneratorViewModel>(
        builder: (
          BuildContext context,
          GeneratorViewModel generatorViewModel,
          Widget? child,
        ) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Form(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 200,
                          minWidth: 200,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            InfoLabel(
                              label: 'Username',
                              child: TextBox(
                                controller: generatorViewModel.userNameController,
                                placeholder: '12345',
                              ),
                            ),
                            const SizedBox(height: 16),
                            InfoLabel(
                              label: 'Password',
                              child: TextBox(
                                controller: generatorViewModel.passwordController,
                                placeholder: 'Pass123!',
                                obscureText: true,
                              ),
                            ),
                            const SizedBox(height: 16),
                            InfoLabel(
                              label: 'Environment',
                              child: TextBox(
                                controller: generatorViewModel.environmentController,
                                placeholder: SOAPConstants.attributeSoapenv,
                              ),
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () => generatorViewModel.onSubmit(context),
                                child: const Text('Generate'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (generatorViewModel.generatedHeader.text.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  const Divider(
                    direction: Axis.vertical,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: InfoLabel(
                              label: 'Generated Header',
                              child: TextBox(
                                controller: generatorViewModel.generatedHeader,
                                style: const TextStyle(
                                  fontFamily: 'Monaco',
                                  fontSize: 12,
                                ),
                                placeholder: 'No header generated yet',
                                readOnly: true,
                                expands: false,
                                maxLines: null,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(FluentIcons.copy),
                                onPressed: generatorViewModel.copyGeneratedHeader,
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(FluentIcons.close_pane),
                                onPressed: generatorViewModel.clearGeneratedHeader,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
