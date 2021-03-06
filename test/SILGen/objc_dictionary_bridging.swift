// RUN: rm -rf %t && mkdir -p %t
// RUN: %build-silgen-test-overlays

// RUN: %target-swift-frontend(mock-sdk: -sdk %S/Inputs -I %t) -Xllvm -new-mangling-for-tests -emit-silgen %s | %FileCheck %s

// REQUIRES: objc_interop

import Foundation
import gizmo

@objc class Foo : NSObject {
  // Bridging dictionary parameters
  // CHECK-LABEL: sil hidden [thunk] @_T024objc_dictionary_bridging3FooC23bridge_Dictionary_param{{[_0-9a-zA-Z]*}}FTo : $@convention(objc_method) (NSDictionary, Foo) -> ()
  func bridge_Dictionary_param(_ dict: Dictionary<Foo, Foo>) {
    // CHECK: bb0([[NSDICT:%[0-9]+]] : $NSDictionary, [[SELF:%[0-9]+]] : $Foo):
    // CHECK:   [[NSDICT_COPY:%.*]] = copy_value [[NSDICT]]
    // CHECK:   [[SELF_COPY:%.*]] = copy_value [[SELF]]
    // CHECK:   [[CONVERTER:%[0-9]+]] = function_ref @_T0s10DictionaryV10FoundationE36_unconditionallyBridgeFromObjectiveCAByxq_GSo12NSDictionaryCSgFZ
    // CHECK:   [[OPT_NSDICT:%[0-9]+]] = enum $Optional<NSDictionary>, #Optional.some!enumelt.1, [[NSDICT_COPY]] : $NSDictionary
    // CHECK:   [[DICT_META:%[0-9]+]] = metatype $@thin Dictionary<Foo, Foo>.Type
    // CHECK:   [[DICT:%[0-9]+]] = apply [[CONVERTER]]<Foo, Foo>([[OPT_NSDICT]], [[DICT_META]])

    // CHECK:   [[SWIFT_FN:%[0-9]+]] = function_ref @_T024objc_dictionary_bridging3FooC23bridge_Dictionary_param{{[_0-9a-zA-Z]*}}F
    // CHECK:   [[RESULT:%[0-9]+]] = apply [[SWIFT_FN]]([[DICT]], [[SELF_COPY]]) : $@convention(method) (@owned Dictionary<Foo, Foo>, @guaranteed Foo) -> ()
    // CHECK:   destroy_value [[SELF_COPY]]
    // CHECK:   return [[RESULT]] : $()
  }
  // CHECK: } // end sil function '_T024objc_dictionary_bridging3FooC23bridge_Dictionary_param{{[_0-9a-zA-Z]*}}FTo'

  // Bridging dictionary results
  // CHECK-LABEL: sil hidden [thunk] @_T024objc_dictionary_bridging3FooC24bridge_Dictionary_result{{[_0-9a-zA-Z]*}}FTo : $@convention(objc_method) (Foo) -> @autoreleased NSDictionary
  func bridge_Dictionary_result() -> Dictionary<Foo, Foo> { 
    // CHECK: bb0([[SELF:%[0-9]+]] : $Foo):
    // CHECK:   [[SELF_COPY:%.*]] = copy_value [[SELF]]
    // CHECK:   [[SWIFT_FN:%[0-9]+]] = function_ref @_T024objc_dictionary_bridging3FooC24bridge_Dictionary_result{{[_0-9a-zA-Z]*}}F : $@convention(method) (@guaranteed Foo) -> @owned Dictionary<Foo, Foo>
    // CHECK:   [[DICT:%[0-9]+]] = apply [[SWIFT_FN]]([[SELF_COPY]]) : $@convention(method) (@guaranteed Foo) -> @owned Dictionary<Foo, Foo>
    // CHECK:   destroy_value [[SELF_COPY]]

    // CHECK:   [[CONVERTER:%[0-9]+]] = function_ref @_T0s10DictionaryV10FoundationE19_bridgeToObjectiveCSo12NSDictionaryCyF
    // CHECK:   [[NSDICT:%[0-9]+]] = apply [[CONVERTER]]<Foo, Foo>([[DICT]]) : $@convention(method) <τ_0_0, τ_0_1 where τ_0_0 : Hashable> (@guaranteed Dictionary<τ_0_0, τ_0_1>) -> @owned NSDictionary
    // CHECK:   destroy_value [[DICT]]
    // CHECK:   return [[NSDICT]] : $NSDictionary
  }
  // CHECK: } // end sil function '_T024objc_dictionary_bridging3FooC24bridge_Dictionary_result{{[_0-9a-zA-Z]*}}FTo'

  var property: Dictionary<Foo, Foo> = [:]

  // Property getter
  // CHECK-LABEL: sil hidden [thunk] @_T024objc_dictionary_bridging3FooC8propertys10DictionaryVyAcCGfgTo : $@convention(objc_method) (Foo) -> @autoreleased NSDictionary
  // CHECK: bb0([[SELF:%[0-9]+]] : $Foo):
  // CHECK:   [[SELF_COPY:%.*]] = copy_value [[SELF]]
  // CHECK:   [[GETTER:%[0-9]+]] = function_ref @_T024objc_dictionary_bridging3FooC8propertys10DictionaryVyAcCGfg : $@convention(method) (@guaranteed Foo) -> @owned Dictionary<Foo, Foo>
  // CHECK:   [[DICT:%[0-9]+]] = apply [[GETTER]]([[SELF_COPY]]) : $@convention(method) (@guaranteed Foo) -> @owned Dictionary<Foo, Foo>
  // CHECK:   destroy_value [[SELF_COPY]]
  // CHECK:   [[CONVERTER:%[0-9]+]] = function_ref @_T0s10DictionaryV10FoundationE19_bridgeToObjectiveCSo12NSDictionaryCyF
  // CHECK:   [[NSDICT:%[0-9]+]] = apply [[CONVERTER]]<Foo, Foo>([[DICT]]) : $@convention(method) <τ_0_0, τ_0_1 where τ_0_0 : Hashable> (@guaranteed Dictionary<τ_0_0, τ_0_1>) -> @owned NSDictionary
  // CHECK:   destroy_value [[DICT]]
  // CHECK:   return [[NSDICT]] : $NSDictionary
  // CHECK: } // end sil function '_T024objc_dictionary_bridging3FooC8propertys10DictionaryVyAcCGfgTo'

  // Property setter
  // CHECK-LABEL: sil hidden [thunk] @_T024objc_dictionary_bridging3FooC8propertys10DictionaryVyAcCGfsTo : $@convention(objc_method) (NSDictionary, Foo) -> ()
  // CHECK: bb0([[NSDICT:%[0-9]+]] : $NSDictionary, [[SELF:%[0-9]+]] : $Foo):
  // CHECK:   [[NSDICT_COPY:%.*]] = copy_value [[NSDICT]]
  // CHECK:   [[SELF_COPY:%.*]] = copy_value [[SELF]]
  // CHECK:   [[CONVERTER:%[0-9]+]] = function_ref @_T0s10DictionaryV10FoundationE36_unconditionallyBridgeFromObjectiveCAByxq_GSo12NSDictionaryCSgFZ
  // CHECK:   [[OPT_NSDICT:%[0-9]+]] = enum $Optional<NSDictionary>, #Optional.some!enumelt.1, [[NSDICT_COPY]] : $NSDictionary
  // CHECK:   [[DICT_META:%[0-9]+]] = metatype $@thin Dictionary<Foo, Foo>.Type
  // CHECK:   [[DICT:%[0-9]+]] = apply [[CONVERTER]]<Foo, Foo>([[OPT_NSDICT]], [[DICT_META]])

  // CHECK:   [[SETTER:%[0-9]+]] = function_ref @_T024objc_dictionary_bridging3FooC8propertys10DictionaryVyAcCGfs : $@convention(method) (@owned Dictionary<Foo, Foo>, @guaranteed Foo) -> ()
  // CHECK:   [[RESULT:%[0-9]+]] = apply [[SETTER]]([[DICT]], [[SELF_COPY]]) : $@convention(method) (@owned Dictionary<Foo, Foo>, @guaranteed Foo) -> ()
  // CHECK:   destroy_value [[SELF_COPY]]
  // CHECK:   return [[RESULT]] : $()

  // CHECK-LABEL: sil hidden [thunk] @_T024objc_dictionary_bridging3FooC19nonVerbatimProperty{{[_0-9a-zA-Z]*}}fgTo : $@convention(objc_method) (Foo) -> @autoreleased NSDictionary

  // CHECK-LABEL: sil hidden [thunk] @_T024objc_dictionary_bridging3FooC19nonVerbatimProperty{{[_0-9a-zA-Z]*}}fsTo : $@convention(objc_method) (NSDictionary, Foo) -> ()
  @objc var nonVerbatimProperty: Dictionary<String, Int> = [:]
}

func ==(x: Foo, y: Foo) -> Bool { }
