From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 28 Jan 2019 15:21:11 +0000
Subject: Re: [PATCH 3/7] sh_eth: offload RX checksum on R7S72100
Message-Id: <916ed105-d499-4ca1-8418-4743b5a7a60d@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
 <0476beba-ea1f-7675-aa08-573b74e84f4e@cogentembedded.com>
 <20190128122053.vb5ifhf34zbnuclp@verge.net.au>
In-Reply-To: <20190128122053.vb5ifhf34zbnuclp@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

On 01/28/2019 03:20 PM, Simon Horman wrote:

>> The RZ/A1H (R7S721000) SoC manual describes the Ether MAC's RX checksum
>> offload the same way as it's implemented in the EtherAVB MACs...
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Regarding this and the remaining patches in this series,
> which add rx-csum offload support in the sh_eth driver for
> various SoCs: has this been tested?

   As I said, I've only tested it on R8A77980.

MBR, Sergei
