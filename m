From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Date: Thu, 04 Dec 2014 17:28:17 +0000
Subject: Re: [PATCH v2 0/7] Pinctrl support for Zynq
Message-Id: <053edb05cd874daf9232cd5e4930df92@BN1BFFO11FD042.protection.gbl>
List-Id: <linux-sh.vger.kernel.org>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdbYPmMksbqciiXv4hHBqx9=b8toA5MgCwGSLteUh+NkZA@mail.gmail.com>
In-Reply-To: <CACRpkdbYPmMksbqciiXv4hHBqx9=b8toA5MgCwGSLteUh+NkZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi Linus,

On Thu, 2014-12-04 at 10:44AM +0100, Linus Walleij wrote:
> On Fri, Nov 28, 2014 at 2:26 AM, Soren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
> > here is v2 of this series. On the functional side, adding the support
> > for USB mux groups is probably the biggest change. Most other changes
> > are mostly cosmetic (typos, function names, documentation, ...).
> > More detailed changelogs are included with the respective patches.
> 
> Unfortunately we are late in the merge cycle.
> 
> But I am *very* fond of this series, and I appreciate your patches
> as *lot* Sören.
> 
> So my plan is to merge your v3 patch set after the merge window
> or whenever you have it ready, with the Zynq driver on top and
> the dependent AMlogic driver too.
> 
> Then we spend the next kernel cycle hashing this out and
> putting some polished generic code in place so we get some
> order.
> 
> This will likely set the pattern for how we expect ACPI pin controllers
> to behave too, so it is work of great importance.
> 
> I hope I can count on you to hang in there and keep driving
> those patches!
> 
> I'll try to provide a deeper look at the indivudual patches now.

Sounds great! After bringing it so far, I wasn't planning of giving up
now :)

The approach you chose sounds good to me. I was currently waiting to see
whether there are a few more change requests coming before sending v3.
The few comments that came in so far I have already fixed up. Since it's
not going to make it into this merge window there may be some more time
now, but in general, I could send v3 any time.

	Sören
