﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace VoOnlineOrderManagemnet
{
    public class OnlineNCDBackOfficeVo
    {
        public int IssuerId { get; set; }
        public int SeriesId { get; set; }
        public string SeriesName { get; set; }
        public int IssueId { get; set; }
        public int IsBuyBackAvailable { get; set; }
        public int Tenure { get; set; }
        public string InterestFrequency { get; set; }
        public string InterestType { get; set; }
        public double DefaultInterestRate { get; set; }
        public double AnnualizedYieldUpto { get; set; }
        public double RenCpnRate { get; set; }
        public double YieldAtCall { get; set; }
        public double YieldAtBuyBack { get; set; }
        public double RenewCouponRate { get; set; }
        public string LockinPeriod { get; set; }
        public double DiscountPrice { get; set; }
        public int IsDiscountAllowed { get; set; }
        public string RedemptionDate {get;set;}
        public double RedemptionAmount { get; set; }
        public int CatgeoryId { get; set; }
        public string CatgeoryName { get; set; }
        public string CatgeoryDescription { get; set; }
        public string ChequePayableTo { get; set; }
        public long MInBidAmount { get; set; }
        public long MaxBidAmount { get; set; }
        public string Subbrokercode { get; set; }

        public int SubCatgeoryId { get; set; }
        public int LookUpId { get; set; }
        public string SubCatgeoryTypeCode { get; set; }
        public double MinInvestmentAmount { get; set; }
        public double MaxInvestmentAmount { get; set; }


        public string AssetGroupCode { get; set; }
        public string AssetInstrumentCategoryCode { get; set; }
        public string AssetInstrumentSubCategoryCode { get; set; }
        public string InitialChequeNo { get; set; }
        public Double FaceValue { get; set; }
        public Double FloorPrice { get; set; }
        public Double FixedPrice { get; set; }

        public string ModeOfIssue { get; set; }
        public string ModeOfTrading { get; set; }
        public DateTime OpenDate { get; set; }
        public DateTime CloseDate { get; set; }
        public DateTime OpenTime { get; set; }
        public DateTime CloseTime { get; set; }
        public DateTime CutOffTime { get; set; }

        public DateTime IssueRevis { get; set; }
        public decimal TradingLot { get; set; }
        public decimal BiddingLot { get; set; }
        public int MinApplicationSize { get; set; }
        public int IsPrefix { get; set; }
        public int TradingInMultipleOf { get; set; }
        public string ListedInExchange { get; set; }
        public string BankName { get; set; }
        public string BankBranch { get; set; }
        public string PutCallOption { get; set; }
        public string IssueName { get; set; }
        public string Rating { get; set; }
        public int FromRange { get; set; }
        public int ToRange { get; set; }

        public int IsActive { get; set; }
        public int IsNominationRequired { get; set; }


        public string ModeOfTenure { get; set; }
        public int SeriesSequence { get; set; }

        public int IsListedinBSE { get; set; }
        public int IsListedinNSE { get; set; }
        public string BSECode { get; set; }
        public string NSECode { get; set; }

        public int IsBookBuilding { get; set; }
        public double BookBuildingPercentage { get; set; }
        public double CapPrice { get; set; }
        public int LookupBankId { get; set; }
        public int NoOfBidAllowed { get; set; }
        public string RtaSourceCode { get; set; }

        public string SyndicateMemberCode { get; set; }
        public string BrokerCode { get; set; }


        public string DiscuountType { get; set; }
        public decimal DiscountValue { get; set; }

        public int MaxQty { get; set; }

        public int IssueSizeQty { get; set; }

        public decimal IssueSizeAmt { get; set; }

        public DateTime AllotmentDate { get; set; }
        public int TradableExchange { get; set; }

    }

    public class OnlineIssueHeader
    {
        public int FileTypeId { get; set; }
        public string ColumnAlias { get; set; }
        public string HeaderName { get; set; }
        public int HeaderSequence { get; set; }
        public string RegularExpression { get; set; }
        public string ColumnName { get; set; }
        public bool IsUploadRelated { get; set; }
    }
}
