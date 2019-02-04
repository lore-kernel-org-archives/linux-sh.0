From: Rob Landley <rob@landley.net>
Date: Mon, 04 Feb 2019 11:55:54 +0000
Subject: Re: [PATCH 7/7] sh_eth: offload RX checksum on SH7763
Message-Id: <2859e252-a900-fdc7-bfd8-d1b7663174f2@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
 <e8ce7a88-b689-6114-66e4-c45a95087a1f@cogentembedded.com>
In-Reply-To: <e8ce7a88-b689-6114-66e4-c45a95087a1f@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

On 1/27/19 11:42 AM, Sergei Shtylyov wrote:
> The SH7763 SoC manual describes the Ether MAC's RX checksum offload
> the same way as it's implemented in the EtherAVB MACs...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

I think this is the chip in the JCI N40 on my desk, how would I test this and
tell it was working? (Is there an existing test program or...?)

Also, can this be tested under QEMU's r2 board emulation?

Rob
