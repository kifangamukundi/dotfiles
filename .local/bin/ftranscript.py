import torch
import typing
import collections
from omegaconf.listconfig import ListConfig
from omegaconf.dictconfig import DictConfig
from omegaconf.base import ContainerMetadata, Metadata
from omegaconf.nodes import AnyNode, IntegerNode, StringNode, FloatNode, BooleanNode, ValueNode

from torch.torch_version import TorchVersion
from pyannote.audio.core.model import Introspection
from pyannote.audio.core.task import Specifications, Problem, Resolution

# Allowlist types for torch.load weights_only=True
torch.serialization.add_safe_globals([
    ListConfig, DictConfig, ContainerMetadata, Metadata, 
    AnyNode, IntegerNode, StringNode, FloatNode, BooleanNode, ValueNode,
    Introspection, Specifications, Problem, Resolution, 
    TorchVersion, typing.Any, list, dict, set, tuple, int, str, float, bool, slice,
    collections.defaultdict, collections.OrderedDict
])

import whisperx.__main__
whisperx.__main__.cli()
