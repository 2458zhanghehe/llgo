/*
 * Copyright (c) 2024 The GoPlus Authors (goplus.org). All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package runtime

import (
	"unsafe"

	"github.com/goplus/llgo/internal/abi"
)

// -----------------------------------------------------------------------------

type InterfaceType = abi.InterfaceType

var (
	TyAny = &InterfaceType{}
)

// -----------------------------------------------------------------------------

type Interface = iface

func MakeAnyInt(typ *Type, data uintptr) Interface {
	tab := &itab{inter: TyAny, _type: typ, hash: 0, fun: [1]uintptr{0}}
	return Interface{
		tab: tab, data: unsafe.Pointer(data),
	}
}

func MakeAnyString(data string) Interface {
	typ := basicTypes[abi.String]
	tab := &itab{inter: TyAny, _type: typ, hash: 0, fun: [1]uintptr{0}}
	return Interface{
		tab: tab, data: unsafe.Pointer(&data),
	}
}

func MakeAny(typ *Type, data unsafe.Pointer) Interface {
	tab := &itab{inter: TyAny, _type: typ, hash: 0, fun: [1]uintptr{0}}
	return Interface{
		tab: tab, data: data,
	}
}

func MakeInterface(inter *InterfaceType, typ *Type, data unsafe.Pointer) Interface {
	tab := &itab{inter: inter, _type: typ, hash: 0, fun: [1]uintptr{0}}
	return Interface{
		tab: tab, data: data,
	}
}

func I2Int(v Interface, t *Type) uintptr {
	if v.tab._type == t {
		return uintptr(v.data)
	}
	panic("I2Int: type mismatch")
}

func CheckI2Int(v Interface, t *Type) (uintptr, bool) {
	if v.tab._type == t {
		return uintptr(v.data), true
	}
	return 0, false
}

func I2Float64(v Interface, t *Type) float64 {
	if v.tab._type == t {
		return bitCastTo64F(uint64(uintptr(v.data)))
	}
	panic("I2Float64: type mismatch")
}

func CheckI2Float64(v Interface, t *Type) (float64, bool) {
	if v.tab._type == t {
		return bitCastTo64F(uint64(uintptr(v.data))), true
	}
	return 0, false
}

func I2Float32(v Interface, t *Type) float32 {
	if v.tab._type == t {
		return bitCastTo32F(uint32(uintptr(v.data)))
	}
	panic("I2Float32: type mismatch")
}

func CheckI2Float32(v Interface, t *Type) (float32, bool) {
	if v.tab._type == t {
		return bitCastTo32F(uint32(uintptr(v.data))), true
	}
	return 0, false
}

//go:linkname bitCastTo64F llgo.bitCastTo64F
func bitCastTo64F(uint64) float64

//go:linkname bitCastTo32F llgo.bitCastTo32F
func bitCastTo32F(uint32) float32

// -----------------------------------------------------------------------------
