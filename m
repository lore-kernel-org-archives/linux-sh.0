From: David Miller <davem@davemloft.net>
Date: Mon, 28 Jan 2019 19:15:47 +0000
Subject: Re: [PATCH 1/7] sh_eth: rename sh_eth_cpu_data::hw_checksum
Message-Id: <20190128.111547.2246294745590521841.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <b73763ac-5909-c95e-efa5-9d44fba9b9bf@cogentembedded.com>
        <CAMuHMdUYH-UzmiMv6LUT=R3gmHSF7LvcaDXszUixtAeXgjTr_Q@mail.gmail.com>
        <42ba30c2-3de0-411b-63e1-9feef2508d9c@cogentembedded.com>
In-Reply-To: <42ba30c2-3de0-411b-63e1-9feef2508d9c@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: geert@linux-m68k.org, netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 28 Jan 2019 14:08:48 +0300

> On 01/28/2019 12:21 PM, Geert Uytterhoeven wrote:
> 
>> On Sun, Jan 27, 2019 at 6:40 PM Sergei Shtylyov
>> <sergei.shtylyov@cogentembedded.com> wrote:
>>> Commit 62e04b7e0e3c ("sh_eth: rename 'sh_eth_cpu_data::hw_crc'") renamed
>>> the field to 'hw_checksum' for the Ether DMAC "intelligent checksum",
>>> however some Ether MACs implement a simpler checksumming scheme, so that
>>> name now seems misleading. Rename that filed to 'csmr' as the "intelligent
>>> checkmum" is always controlled by the CSMR register.
>> 
>> checksum
> 
>    Oops! Do I need to repost?

Please repost the series, thank you.
