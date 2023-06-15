from abc import ABC, abstractmethod
from typing import List, Optional

from model.ral_method import RalMethod


class RalMethodRepository(ABC):
    """
    Interface for a repository to store and retrieve [RalMethod]s from a database.
    """

    @abstractmethod
    def get_by_uid(self, uid: str) -> Optional[RalMethod]:
        """
        Returns the [RalMethod] with the given uid. Looks for 'identity.UID' == uid in the database.
        """
        pass

    @abstractmethod
    def get_by_ral_type(self, ral_type: str) -> List[RalMethod]:
        """
        Returns all [RalMethod]s with the given ralType. Looks for 'template.RALType' == ralType in the database.
        """
        pass

    @abstractmethod
    def create(self, ral_method: RalMethod, override_if_exists: bool) -> None:
        """
        Creates a new [RalObject] in the database. If [override_if_exists] is true, the [RalObject] will be overwritten if it already exists. Otherwise, an error will be thrown.
        """
        pass