abstract class UseCase<Type, Parameter> {
  Type call([Parameter parameter]);
}


abstract class UseCaseTwoParam<Type, Parameter1,Parameter2> {
  Type call([Parameter1 parameter1,Parameter2 parameter2]);
}

class NoParameter {}