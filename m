From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 28 Mar 2014 20:10:29 +0000
Subject: Re: [PATCH v5] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <5335E53C.6020208@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395400154-25710-1-git-send-email-ben.dooks@codethink.co.uk>	<20140328.142606.2032782733436495474.davem@davemloft.net>	<5335CCBF.8030606@codethink.co.uk> <20140328.160024.136488246522581222.davem@davemloft.net>
In-Reply-To: <20140328.160024.136488246522581222.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, ben.dooks@codethink.co.uk
Cc: linux-kernel@lists.codethink.co.uk, netdev@vger.kernel.org, linux-sh@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com

Hello.

On 03/28/2014 11:00 PM, David Miller wrote:

>> I thought it was against the net next tree, given the number of
>> patches that are currently being applied to the sh_eth driver.

> Fair enough, applied to net-next, thanks!

    It probably makes sense to queue this for the stable kernels as well.

WBR, Sergei

