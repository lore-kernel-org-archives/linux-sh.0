From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Thu, 21 Nov 2013 10:39:37 +0000
Subject: Re: [PATCH 9/9] ARM: shmobile: lager: add PCI USB host controllers
Message-Id: <CAO3366x8gQcLarXPq_=beL8eAVbSWKuR5BRC=dvD+2P-cvD4EA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384969086-8920-10-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1384969086-8920-10-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 20, 2013 at 10:24 PM, Valentine
<valentine.barshak@cogentembedded.com> wrote:
> On 11/20/2013 09:38 PM, Ulrich Hecht wrote:
>> +       usb_bind_phy("0000:00:01.0", 0, "usb_phy_rcar_gen2");
>> +       usb_bind_phy("0000:00:02.0", 0, "usb_phy_rcar_gen2");
>
> You don't seem to register PCI controller 0 here. Thus, PCI bus 0 is the
> root bus of controller 1
> which has nothing to do with the USB phy.

Good point. I'll remove those.

CU
Uli
