From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 31 Mar 2018 21:28:20 +0000
Subject: Re: [PATCH net-next 1/2] sh_eth: add sh_eth_cpu_data::no_xdfar flag
Message-Id: <f2d1b237-fa73-0aab-ef2e-e7cccdfa89f7@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <998029b4-9400-ebc3-51c1-623c3f72b6cc@cogentembedded.com>
 <233e32d1-947b-2377-3d1f-39d5d83bd3f7@cogentembedded.com>
In-Reply-To: <233e32d1-947b-2377-3d1f-39d5d83bd3f7@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

On 04/01/2018 12:22 AM, Sergei Shtylyov wrote:

> The commit 6ded286555c2 ("sh_eth: Fix RX recovery on R-Car in case of RX
> ring underrun") added a check for an bad RDFAR offset in sh_eth_rx(), so
> that the code could work on the R-Car Ether controllers which don't have
> this register (and TDFAR), then the commit 3365711df02 ("sh_eth: WARN on

   Oops, only 11 digits! Should have been 3365711df024. :-)

> access to a register not implemented in a particular chip") replaced
> offset 0 with 0xffff. Adding/checking the 'no_xdfar' bit field in the
> 'struct sh_eth_cpu_data' instead results in less object code...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

MBR, Sergei
