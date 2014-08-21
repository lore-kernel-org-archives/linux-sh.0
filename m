From: Vivek Gautam <gautam.vivek@samsung.com>
Date: Thu, 21 Aug 2014 12:56:23 +0000
Subject: Re: [PATCH v3] usb: hcd: add generic PHY support
Message-Id: <CAFp+6iEABcQuEkpQGB4Yb2C_i8YsVWXf=31mbm7Go1oiXQZ2xw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <538891DC.605@renesas.com>
In-Reply-To: <538891DC.605@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 30, 2014 at 7:46 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 05/30/2014 06:12 PM, Yoshihiro Shimoda wrote:
>
>>  From Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
>
>    Should be "From:".
>
>
>> Add the generic PHY support, analogous to the USB PHY support. Intended it
>> to be
>> used with the PCI EHCI/OHCI drivers and the xHCI platform driver.
>
>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>> This patch is against the 'usb-next' branch of Greg KH's 'usb.git' repo.
>> (commit id = 70d2f61fc7559df3d5be32a9d01efdb9ee1b11d8)
>
>
>    I was pondering on reposting this patch, along with the R8A779x device
> tree changes using it as Greg KH requested to see the users of this patch...

Are we planning a repost of this patch, since we definitely have user
for this change [1],
apart from Antoine's series [2] which makes changes on top of this patch.

It will be easier for us if this patch gets pulled in for 3.18.

[1] [PATCH v4 2/4] usb: host: xhci-plat: Get PHYs for xhci's hcds
     http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/272833.html

[2] [PATCH v2 0/8] usb: add support for the generic PHY framework
     http://www.spinics.net/lists/linux-usb/msg110557.html



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
