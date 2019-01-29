From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 29 Jan 2019 16:03:00 +0000
Subject: Re: [PATCH 3/7] sh_eth: offload RX checksum on R7S72100
Message-Id: <56c41482-bffe-a831-2126-24e711623235@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
 <0476beba-ea1f-7675-aa08-573b74e84f4e@cogentembedded.com>
 <20190128122053.vb5ifhf34zbnuclp@verge.net.au>
 <916ed105-d499-4ca1-8418-4743b5a7a60d@cogentembedded.com>
 <20190129080004.blc3jrt5y2j7dauo@verge.net.au>
 <e5b05616-d9b3-3c0a-189b-4fc02190c8a5@cogentembedded.com>
 <TY1PR01MB15628BF7F66DCCE3CD1827D58A970@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB15628BF7F66DCCE3CD1827D58A970@TY1PR01MB1562.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Brandt <Chris.Brandt@renesas.com>, Simon Horman <horms@verge.net.au>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On 01/29/2019 06:02 PM, Chris Brandt wrote:

>>> As you may have guessed the implication of my question is that
>>> IMHO it would be best only to add this feature to SoCs where
>>> it has been tested.
>>
>>    You don't trust the manuals? :-)
>>
>> MBR, Sergei
> 
> How were you testing this feature with the R8A77980?

  Like Simon, I used perf/netperf, you can see it in the patch #2's
description. You have other ideas?

> Chris

MBR, Sergei
