From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 07 May 2010 09:50:48 +0000
Subject: Re: [PATCH] sh: fix the id of scif in SH7757
Message-Id: <4BE3E278.9000007@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4BE3DB0C.3020006@renesas.com>
In-Reply-To: <4BE3DB0C.3020006@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Fri, May 07, 2010 at 06:19:08PM +0900, Yoshihiro Shimoda wrote:
>> Because the value of CONFIG_SERIAL_SH_SCI_NR_UARTS is 3.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> If there are only 3 devices, then why do we have them named scif2, scif3,
> and scif4? Presumably there used to be a scif0 and scif1?

Yes, this cpu also has scif0 and scif1.
But those scif is only named "SCIF0" and "SCIF1".
Actually those functions are 16550 based serial port.
So I made this patch.

Thanks,
Yoshihiro Shimoda
