From: Francois Romieu <romieu@fr.zoreil.com>
Date: Tue, 15 May 2012 13:43:07 +0000
Subject: Re: [PATCH v3 6/6] net: sh_eth: use NAPI
Message-Id: <20120515134307.GA31377@electric-eye.fr.zoreil.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4FB0AA7C.1000603@renesas.com> <20120514.185034.399229364191924851.davem@davemloft.net> <4FB1DFF0.4040709@renesas.com> <20120515.010753.2012331320750491448.davem@davemloft.net> <4FB225F1.20407@renesas.com>
In-Reply-To: <4FB225F1.20407@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org

Shimoda, Yoshihiro <yoshihiro.shimoda.uh@renesas.com> :
[...]
> I will modify the code as the following. Is it correct?

No.

Please take a look at tg3, especially the ...mb() calls and rework the
queue disabling part in the xmit handler. Btw sh_eth_txfree has no
business being called from the xmit and poll handlers at the same time.

There is no memory barrier in the xmit handler. It it not clear if the
poll thread always sees tx ring status and cur_tx updates in the same
order or not. If not, the driver may unmap before the device actually
accesses skb buffer.

-- 
Ueimor
