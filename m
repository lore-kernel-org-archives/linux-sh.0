From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 11 Mar 2014 12:40:12 +0000
Subject: Re: NFS root on Koelsch reference
Message-Id: <531F042C.5070903@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
In-Reply-To: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/03/14 10:47, Geert Uytterhoeven wrote:
> Hi Sergei,
>
> On Fri, Mar 7, 2014 at 7:57 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
>>> We also need a fix for the Micrel PHY to set the LED mode on the
>>> Lager board. I've sent that but it seems to have stalled.
>>
>>     While we're not having it, try changing "renesas,ether-link-active-low"
>> prop to "renesas,no-ether-link" in the Koelsch device tree file.
>
> Thanks, that decreases the part between nfsroot mount and system ready
> from 54 s to 15 s, hence
>

The LED mode patch looks like it is now in net-next, so all that needs
to be done is chase-up the proper of linking for the PHY and we can fix
these issues in the DT.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
