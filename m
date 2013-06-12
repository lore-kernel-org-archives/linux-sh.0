From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 12 Jun 2013 19:13:14 +0000
Subject: Re: [PATCH net-next] net: sh_eth: fix incorrect RX length error if R8A7740
Message-Id: <51B8C84A.7000708@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51B7CFFB.7090801@renesas.com> <51B88271.1030101@cogentembedded.com>
In-Reply-To: <51B88271.1030101@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

Hello.

On 06/12/2013 06:15 PM, Sergei Shtylyov wrote:

>> This patch fixes an issue that the driver increments the "RX length
>> error"
>> on every buffer in sh_eth_rx() if the R8A7740.
>> This patch also adds a description about the Receive Frame Status bits.

>      Thank you.

>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>   This patch is based on the latest net-next.git.

>     Since this is a fix, it should have been done against 'net.git'.

    David, this patch applies to the recent net.git repo with offset.
Could you merge it there and also queue for stable?

WBR, Sergei

