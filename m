Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AE0C43334
	for <linux-sh@archiver.kernel.org>; Fri,  8 Jul 2022 10:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiGHKX4 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 8 Jul 2022 06:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbiGHKX4 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 8 Jul 2022 06:23:56 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E201F1FCD1
        for <linux-sh@vger.kernel.org>; Fri,  8 Jul 2022 03:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC1An5KWy9/Gb8PbC9XowVuplZR6SUbm2Mluguqj/c4ueuwXArF2ho8m456e589N2ccea4ncuAgyGoItYiyYGMrDvG1tmXY5KwhhGzqVHIBAgZgGqDQ/o4vBpM12nVrLY29EkUSXF2oifjNr/SOMA0h84EXY/UQSFgVjFPFNi41B8Yg+SM6tl0zLBUTMPDIYwLGWJfPrphLuCNhq6z/oFyYu0ULfnWgNKqi84Q0Y88wm/OHPF5TNS9uMgctrUQTjdLm7kEvZncjOb7gdMXS8Nls68AtyGtw4Nb1nXWx9WEmCduuTkFoBTB48NgxEa+Cqw476My5F9Ww+dklWWdeBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nctdQjF/w9M7pV9yh5n9NqfGHgJhbu/W7r3c9MlWdE=;
 b=iLLK2EJ/yDseidCKGzIVYiu7fHuT8t97McZolr5eRBcptlovJILgjg2GlvYjkCkH8VgJNomIgtaYeU/x1ZMruJ81jdPc0ZBiQUAVZb6yLSsPmSCWJAtWW7z2yifBGPw040WetoOJUwq/+gquWmpjysnHMW4wxKDMhrjD7wFP6/CUUQfK4xcAl2FRTfhlyZQEt2Sd4p46xJGH0VwxV2WaqretV4OFgM5Faa/v5BRuPN9xHF4T6T5aRO1tB89+Qoz8sKIievW5IWxjteEnHw7GWq0u+MvsYMsk2GuMLesjB7LPFqzzskBtUAm+v2UbuBkSMTqDuPGOLv+MyEf+DsmLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nctdQjF/w9M7pV9yh5n9NqfGHgJhbu/W7r3c9MlWdE=;
 b=bnw3kUU5xh0owbVBZl0aL3pqrQUBSbfkp28/fBYRZ9OcYvtxIhgsRecUVxrUe0gTGzZ131eD5r0SAxjqJiOHy0rRLGffZluJcK4OdPV+Jb8PQaFw48WG2XfyHz/jvZP4dsTpknGEST6etRvfi5HrDcCXLenuBdnxL/2HpuvRQa0=
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com (2603:1096:400:de::11)
 by OSAPR01MB3155.jpnprd01.prod.outlook.com (2603:1096:604:6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 10:23:51 +0000
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::3c36:680f:3292:4a79]) by TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::3c36:680f:3292:4a79%9]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 10:23:51 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [PATCH] sh: clk: Extend valid clk ptr checks using IS_ERR_OR_NULL
Thread-Topic: [PATCH] sh: clk: Extend valid clk ptr checks using
 IS_ERR_OR_NULL
Thread-Index: AQHYboXOA2bPkjoa2kCNuWAdboYAAK10YsWAgAAo7WA=
Date:   Fri, 8 Jul 2022 10:23:51 +0000
Message-ID: <TYYPR01MB7086F6675221C3FBE034457BF5829@TYYPR01MB7086.jpnprd01.prod.outlook.com>
References: <20220523091633.5217-1-phil.edworthy@renesas.com>
 <CAMuHMdWdd7VGLpUFo--DdYJRtHhrEH-j9wm1nb66BZZ6o82Sug@mail.gmail.com>
In-Reply-To: <CAMuHMdWdd7VGLpUFo--DdYJRtHhrEH-j9wm1nb66BZZ6o82Sug@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd8a8061-dc54-4070-04f1-08da60cbf3fb
x-ms-traffictypediagnostic: OSAPR01MB3155:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /d73B1tWnVPuJi8vu0b44iYSl2uDq4r/9qzhnxMXRMOO3z10W+Yj1TmH5UDkbOoZL6OpEcBcOBWZa2nUtjY9Yx9SH0rhAXEI/JYCdBuDEw9FbLx99JWANTq/XTR+LxLk5FldVDWLV5bD8E0v+r0Nag1Y4YfkFFh78GyV7ZD9Q+aIJ+aeRaU+RqipCujrAkn6KOSe4rnjpZBtL26eY+1ycequJc/pMeQwT4XwnpgrBsVjBrISxJ+h7mPj+vqeTVggDcvURC2hpBbHfEcPAcF/PmhXF5PUzy1K9hW0ssUi2IpVtqNUpiCnRD1OtBjzCrPRJ9aiwmyfmIcmoFm+VMYjVuMGDJ5raLGk45i8/WgDnoP/Wsx8J6daB4HissMOiFq4fKNwa2ZS2YdruZANkK5ETuDqNI+BMbZNeWPDx3dZa6pxudFn8QoatF/C//Ww6TZyYQnLU0l3z0kBj/SxzaDGT9OevxJoEcPLHiqhLGV7tIEiHTXLGqGLtZ2AFwp4qbGgkBFZpAuWo3znpofbpYhC3kWcdBip2201o3hBE5RyiEqw8EoEOxbRJ0XJfvt7rrEVFz3UH0bKDL6wMQjJ0ZglQhn0e6WDrR0dj4yYDUmtIe5Gnu9/qtyTP+wLBO8USjQpnvDXRkDiay9H8eUWQS9QyGiCbZRXoC8bDdlZ4q6niAr9posHIw0IMDXiHpgPcjFXXDbX5zMTAgj4/8C/SFJdPh5zuR6Qwcn/VS9pGsNcl+jkMVu8Jeqw2Ze70dPPCTt6poxlTXNRX2JexEPOMAolgfnDGNwMz9F50hp3xKR4x4yuIqXlcQVZ5Dh2A1lqr9ws
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7086.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(66476007)(76116006)(66946007)(86362001)(54906003)(44832011)(8676002)(4326008)(66556008)(5660300002)(66446008)(52536014)(6916009)(64756008)(83380400001)(38070700005)(186003)(26005)(9686003)(33656002)(41300700001)(7696005)(6506007)(316002)(478600001)(71200400001)(8936002)(38100700002)(122000001)(55016003)(2906002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW43NGFzdkxBZ2hNSUFHUzhtR3JYUlQxNjdha1FCK2VRVGlXZmIvbldnVmw0?=
 =?utf-8?B?UlRrMkNDM0lSeVlrOFdWREtnSlR3Tld4Ky9Qc3FzYnNOQWpxVFVNRzhaY2JK?=
 =?utf-8?B?cy80aXRhSEpsRGZaTkY2VSt5UWtvcFU3Q0tOV2h3OE40aGNSM0tGOVZvTk9D?=
 =?utf-8?B?Q0J4RFc5OUlHa1JQRmlMNjRwZENvM1VMa3JwYlZPaGtpUElyODhZdnJnV3dN?=
 =?utf-8?B?bXFwY3NTMzk0N0hVaUlYSExQRVpsME1NbWZPM2cvYzFiV1phaTZtZnVBdnNJ?=
 =?utf-8?B?UGhySUpGd0c0Ums3bUoxajcyZFdXL0owcnBPdkVCNUFVaDlyd0pJNzFlbnpj?=
 =?utf-8?B?TFJkcHBISTZOMEFlcHU1WkJEcGlxdEhwZXVxMUdrenhXbjVaZmVIWnZ1TFhv?=
 =?utf-8?B?Z1g4QjhlcXl2YVBzcTcrdzVDbjVPai9GT3VKZmx0amNzcDh0MFYyQitVcjdh?=
 =?utf-8?B?M1MwUmZYcGlrU0t1eG05dWJhZ1BQRFFhYkI0bE5pSllkWkxSWldaU2Jrdy9F?=
 =?utf-8?B?TlFBdE5VUEF1clB4ejc4MHZwMGRabjV0czVQSWZMVUl1TmREREF2UzNCNngx?=
 =?utf-8?B?MDM2NDBVYURGeXRoZS9OT1BmNUFuRUFaRDZTNTdWRlg2TC9LOFM5LytCb1JX?=
 =?utf-8?B?ejBKUUx0WTJpK3RFL1pqUW5Jdk1PRVlvMnlsRGVvSjFTbFBxR3VwYUxRTDla?=
 =?utf-8?B?S0ZXMDFhalRYREhhRll1Ujd6NFoyYVFFYVpUeFhYK044TzljaUh3bHRMVE1V?=
 =?utf-8?B?YTNFbWc1YXpMc3BsQjB0WFBaUTl0akhjRkplaVNtNXZScEpXbjduSDVucG5E?=
 =?utf-8?B?bnV4Y0JRWlYraEZlNzljVWNTZmlHaTNvNXVMZVNkZ3c3RXBvMk9HeDRqZnVS?=
 =?utf-8?B?VXNvTWtPV3J6eTBLTzg0TDJ1cXZNbFAzaDYzb0dPcEtGaElsS2s4Q09lS3Zz?=
 =?utf-8?B?amM1MW1UanJUOGh6MUlvMDJ4bFh1K2NhM1BzRTQwbHNBL3MwZksxMWdvaFJK?=
 =?utf-8?B?ZnpQai9XMkY4RTNMR3o2R1Y4d3JHdjlDMTVnUmhJL2gvRWJTWFZ1dytBcVNj?=
 =?utf-8?B?elk4QU1XOEdsTXNFVVRDbWJ4aEFqZngxempkcVg3TzVUUHJrTEtnditaSW1B?=
 =?utf-8?B?b0VkS1lxQzBVTlgwdDRBbnoxanEzbm5iS3pqWUVuZ1prWHNtc05YbWRyazdu?=
 =?utf-8?B?RTRacW84M09MYW1KMU91QXdlRGYyUjc0R1NWSFhQeVlBYzBtNDFRVHpZbFlk?=
 =?utf-8?B?Y2lINFAvdDd3bjNqWnV0cjUvU3J3L0MwZWp6NnpDODQvM3dCMHZCNlFHa3dm?=
 =?utf-8?B?MWpHa2JUNWNIbll0Yy8ySjRRYVZ3am41REVQajNOb3dHdk1zekVaaHhDVkpP?=
 =?utf-8?B?N1pRUmpIbElQSWhIbG9ENWsrTDgzN0VkUWJybGF0S3J3SFhCVVc1czFwVlpF?=
 =?utf-8?B?d05mQWdMM3FMRTFsSndZV1BMRWs3R2hFNWQvZjI1MFdpUFloOS9Jc2dxU1B4?=
 =?utf-8?B?R3VFNGFzd1ljR3AwUDcvOGJiOS9STWFxdndPbFh3UWd3YzFSV1BCZno2clRI?=
 =?utf-8?B?WnVZVjQ4eTR0bkUySWZiL0g1NmxGcjh6MXlSeFdBKzdHeEZpaWp0dm5idU9C?=
 =?utf-8?B?eElMZ3RuNGpSSEY0Qnp4VzVrY0NWbW9NUHFnZnpBYjJVWmZDQXYxQlRxcmtN?=
 =?utf-8?B?cWMvNlJ2T3hRWlh4NGowTTFtT05tMHRHNjRnQWNjQ21IN0FvWEwwS2FSZUFp?=
 =?utf-8?B?aHhuT3pjNGRyUnV1cjdTUFFZMFRxN0c3bE5kWDl5cXZKYkFDb1NlTHFjd2dm?=
 =?utf-8?B?NStnbjcrUlF0OXJtSlNGMHpwK1FGKzcxT2NIbXdvU1RXbGdSaFhMLzcyU3U3?=
 =?utf-8?B?bUtuTm1jd0U4MUY0L29jUFA1SVpYMGJmU0tzL0JUWmlKTDNzeFl0SUJBNzJ6?=
 =?utf-8?B?cnMyMjczblBwSExITXFKM3JzZm1ad1c5MG0yeGtZQ3JMTGwzUWtTNFZBRDIx?=
 =?utf-8?B?NUpEV3Rmd0tUMmkwSllHNStmU0N2dlNteERreVFTNnVXSDFqbElENGo0cmN2?=
 =?utf-8?B?ZFRBOUo5NEc5WWJXbndLL1Y3WlMxaStvdVd5dDRiUjRFZkFtMGFhV25uSUtq?=
 =?utf-8?B?Y1JsTHd5allzOFBMOVpNaTJmbHZGdS93VjNPcTRGclNYK1FLL0FySkRza2tN?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7086.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8a8061-dc54-4070-04f1-08da60cbf3fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:23:51.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpxL3kv17bz/JkfyS1/bl0SNgWe/LnwHxWkhz0hTQ1aeir8njnAU3WmLN2hnkF4/705NBIQtcJegNBD7itWbZiNIGyqydSeD7EVNw/okeCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3155
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDA4IEp1bHkgMjAyMiAwODo1NCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IE9uIE1vbiwgTWF5IDIzLCAyMDIyIGF0IDExOjE2IEFNIFBoaWwgRWR3b3J0aHkgd3Jv
dGU6DQo+ID4gSW4gb3JkZXIgdG8gYWxsb3cgYWxsIGRyaXZlcnMgdG8gY2FsbCBjbGsgZnVuY3Rp
b25zIHdpdGggYW4gaW52YWxpZCBjbGsNCj4gPiBwdHIsIGVuc3VyZSB3ZSBjaGVjayBub3Qgb25s
eSBmb3IgYSBOVUxMIGNsayBwdHIsIGJ1dCBhbHNvIGZvciBlcnJvcnMNCj4gPiBiZWZvcmUgdXNp
bmcgaXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaGlsIEVkd29ydGh5IDxwaGlsLmVkd29y
dGh5QHJlbmVzYXMuY29tPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gPiAt
LS0gYS9kcml2ZXJzL3NoL2Nsay9jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3NoL2Nsay9jb3Jl
LmMNCj4gPiBAQCAtMjk0LDcgKzI5NCw3IEBAIGludCBjbGtfZW5hYmxlKHN0cnVjdCBjbGsgKmNs
aykNCj4gPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gICAgICAgICBpbnQgcmV0
Ow0KPiA+DQo+ID4gLSAgICAgICBpZiAoIWNsaykNCj4gPiArICAgICAgIGlmIChJU19FUlJfT1Jf
TlVMTChjbGspKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gDQo+IGRy
aXZlcnMvY2xrL2Nsay5jOmNsa19lbmFibGUoKSBvbmx5IGNoZWNrcyBmb3IgTlVMTCwgc28gSSB0
aGluayB0aGlzDQo+IHBhcnQgc2hvdWxkIGJlIGRyb3BwZWQuDQo+IA0KLi4uDQo+ID4NCj4gPiAg
ICAgICAgIGlmIChsaWtlbHkoY2xrLT5vcHMgJiYgY2xrLT5vcHMtPnJvdW5kX3JhdGUpKSB7DQo+
IA0KPiBTbyBpdCdzIGp1c3QgY2xrX2Rpc2FibGUoKSB0aGF0IG5lZWRzIHRoZSBpbXByb3ZlZCBj
aGVja2luZywgc28geW91IGNhbg0KPiBhbHdheXMgY2FsbCBpdCBpbiBjbGVhbnVwIGNvZGUsIHJl
Z2FyZGxlc3Mgb2YgZmFpbGluZyB0byBnZXQgdGhlIGNsb2NrLg0KDQpPaywgSSBzZWUgbm93LiBO
VUxMIGlzIGEgdmFsaWQgY2xrIHB0ciwgaGVuY2UgdGhlIFNIIGRyaXZlciBuZWVkcyB0bw0KY2hl
Y2sgZm9yIGl0LCB3aGVyZWFzIGVycm9ycyBuZWVkIHRvIGJlIGNhdWdodCBiZWZvcmUgdHJ5aW5n
IHRvIGFjdHVhbGx5DQp1c2UgdGhlIG90aGVyIGNsb2NrIGZ1bmN0aW9ucy4NCg0KVGhhbmtzDQpQ
aGlsDQo=
