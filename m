From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 12 Jun 2013 14:15:13 +0000
Subject: Re: [PATCH net-next] net: sh_eth: fix incorrect RX length error if R8A7740
Message-Id: <51B88271.1030101@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51B7CFFB.7090801@renesas.com>
In-Reply-To: <51B7CFFB.7090801@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Cc: netdev@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

Hello.

On 12-06-2013 5:33, Shimoda, Yoshihiro wrote:

> This patch fixes an issue that the driver increments the "RX length error"
> on every buffer in sh_eth_rx() if the R8A7740.
> This patch also adds a description about the Receive Frame Status bits.

     Thank you.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   This patch is based on the latest net-next.git.

    Since this is a fix, it should have been done against 'net.git'.

WBR, Sergei

