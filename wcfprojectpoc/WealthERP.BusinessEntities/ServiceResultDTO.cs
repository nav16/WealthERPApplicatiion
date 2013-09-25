﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace WealthERP.BusinessEntities
{
    /// <summary>
    ///   Service Result DTO
    /// </summary>
    [DataContract]
    [Serializable]
    public class ServiceResultDTO
    {
        [DataMember(Order = 0)]
        public bool  IsSuccess { get; set; }

        [DataMember(Order = 1)]
        public string Message { get; set; }

    }
}
