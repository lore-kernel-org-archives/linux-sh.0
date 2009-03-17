From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Tue, 17 Mar 2009 07:40:17 +0000
Subject: Re: [PATCH] sh: sh7763rdp: Change IRQ number for sh_eth of sh7763rdp
Message-Id: <49BF53E1.6030600@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49BF3AD6.8090806@renesas.com>
In-Reply-To: <49BF3AD6.8090806@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Tue, Mar 17, 2009 at 02:53:26PM +0900, Nobuhiro Iwamatsu wrote:
>> IRQ for sh_eth of sh7763rdp became multi handling.
>> Therefore, the IRQ number of sh_eth is changed, too.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> 
> On Tue, Mar 17, 2009 at 02:54:37PM +0900, Nobuhiro Iwamatsu wrote:
>> Espt-giga is the board which used SH7763.
>> This supports serial, Gigabit ether, USB host and MTD.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> 
> I've rolled the defconfig patch in with the board patch and checked these
> in, thanks.
> 

OK, thank you a lot.

Best regards,
  Nobuhiro
