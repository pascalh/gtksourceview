-- -*-haskell-*-
--  GIMP Toolkit (GTK) Widget CellRendererCombo
--
--  Author : Duncan Coutts
--
--  Created: 2 November 2005
--
--  Version $Revision: 1.2 $ from $Date: 2005/11/18 15:41:07 $
--
--  Copyright (C) 2005 Duncan Coutts
--
--  This library is free software; you can redistribute it and/or
--  modify it under the terms of the GNU Lesser General Public
--  License as published by the Free Software Foundation; either
--  version 2.1 of the License, or (at your option) any later version.
--
--  This library is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--  Lesser General Public License for more details.
--
-- |
-- Maintainer  : gtk2hs-users@lists.sourceforge.net
-- Stability   : provisional
-- Portability : portable (depends on GHC)
--
-- Renders a combobox in a cell
--
-- * Module available since Gtk+ version 2.6
--
module Graphics.UI.Gtk.TreeList.CellRendererCombo (
-- * Detail
-- 
-- | 'CellRendererCombo' renders text in a cell like 'CellRendererText' from
-- which it is derived. But while 'CellRendererText' offers a simple entry to
-- edit the text, 'CellRendererCombo' offers a 'ComboBox' or 'ComboBoxEntry'
-- widget to edit the text. The values to display in the combo box are taken
-- from the tree model specified in the model property.
--
-- The combo cell renderer takes care of adding a text cell renderer to the
-- combo box and sets it to display the column specified by its text-column
-- property. Further cell renderers can be added in a handler for the
-- editing-started signal.

-- * Class Hierarchy
-- |
-- @
-- |  'GObject'
-- |   +----'Object'
-- |         +----'CellRenderer'
-- |               +----'CellRendererText'
-- |                     +----CellRendererCombo
-- @

#if GTK_CHECK_VERSION(2,6,0)
-- * Types
  CellRendererCombo,
  CellRendererComboClass,
  castToCellRendererCombo,
  toCellRendererCombo,

-- * Constructors
  cellRendererComboNew,

-- * Attributes
  cellComboModel,
  cellComboTextColumn,
  cellComboHasEntry,
#endif
  ) where

import Monad	(liftM)

import System.Glib.FFI
import System.Glib.Attributes			(Attr, ReadWriteAttr)
import System.Glib.Properties
import Graphics.UI.Gtk.Abstract.Object		(makeNewObject)
{#import Graphics.UI.Gtk.Types#}

{# context lib="gtk" prefix="gtk" #}

#if GTK_CHECK_VERSION(2,6,0)
--------------------
-- Constructors

-- | Creates a new 'CellRendererCombo'. Adjust how text is drawn using object
-- properties. Object properties can be set globally (with 'cellRendererSet').
-- Also, with 'TreeViewColumn', you can bind a property to a value in a
-- 'TreeModel'. For example, you can bind the \"text\" property on the cell
-- renderer to a string value in the model, thus rendering a different string
-- in each row of the 'TreeView'.
--
cellRendererComboNew :: IO CellRendererCombo
cellRendererComboNew =
  makeNewObject mkCellRendererCombo $
  liftM (castPtr :: Ptr CellRenderer -> Ptr CellRendererCombo) $
  {# call gtk_cell_renderer_combo_new #}

--------------------
-- Attributes

-- | Holds a tree model containing the possible values for the combo box. Use
-- the text_column property to specify the column holding the values.
--
cellComboModel :: (CellRendererComboClass self, TreeModelClass treeModel) => ReadWriteAttr self TreeModel treeModel
cellComboModel = newAttrFromObjectProperty "model"
  {# call pure unsafe gtk_tree_model_get_type #}

-- | Specifies the model column which holds the possible values for the combo
-- box. Note that this refers to the model specified in the model property,
-- /not/ the model backing the tree view to which this cell renderer is
-- attached.
--
-- Allowed values: >= -1
--
-- Default value: -1
--
cellComboTextColumn :: CellRendererComboClass self => Attr self Int
cellComboTextColumn = newAttrFromIntProperty "text-column"

-- | If @True@, the cell renderer will include an entry and allow to enter
-- values other than the ones in the popup list.
--
-- Default value: @True@
--
cellComboHasEntry :: CellRendererComboClass self => Attr self Bool
cellComboHasEntry = newAttrFromBoolProperty "has-entry"
#endif