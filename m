From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 26 Aug 2011 09:23:10 +0000
Subject: Re: [PATCH][RESEND] ARM: mach-shmobile: sh7372 generic
Message-Id: <20110826092310.GF11250@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20110826051205.24370.44903.sendpatchset@rxone.opensource.se>
In-Reply-To: <20110826051205.24370.44903.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 26, 2011 at 05:44:04PM +0900, Magnus Damm wrote:
> Good question. This was posted before the 3.1-rc merge window, but
> didn't make it into mainline for some unknown
> reason. I'm all for merging things sooner than later if possible, but
> I understand if 3.1-rc is out of the question at this point.
> 
> If you are offering to queue this up for the 3.2 merge window then I
> am instead suggesting that Rafael picks this up in his PM tree because
> there are other PM related patches that build on top of this one.

If Rafael wants to pick it up, that's fine.

> While at it, for the 3.1 release, would it be possible to update the
> mach-types list in mainline? We have patches for the Kota2 board that
> depend on the mach-type update.

I dropped my mach-types update (which was required to fix a build error -
because a platform was introduced into mainline without its entry in
mach-types) as the update was causing a number of problems with other
platforms and drivers in mainline.

I'm not sure what the long term future of mach-types is, as it's become
quite a burden to manually update it each time due to the amount of crap
now contained in there, and it seems automated filtering results in
breakage.

I think the whole interface to it needs to be revised so that it is
purely read-only, and editing is done via human interaction adding a
level of manual approval to the system.  It's the only way I can think
of stopping the 'ARM', 'IMX', etc like entries from being added, along
with ensuring that the machine_is_xxx() and MACH_TYPE_xxx() names always
match.
