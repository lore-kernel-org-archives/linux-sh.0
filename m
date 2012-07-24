From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Jul 2012 15:20:20 +0000
Subject: Re: [RFC][PATCH 0/14] PM / shmobile: Pass power domain information via DT (was: Re: [RFD] PM: Device
Message-Id: <201207241520.20674.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201207032302.17805.rjw@sisk.pl> <201207162315.49073.rjw@sisk.pl> <201207211917.12519.rjw@sisk.pl>
In-Reply-To: <201207211917.12519.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Magnus Damm <magnus.damm@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Linux-sh list <linux-sh@vger.kernel.org>

On Saturday 21 July 2012, Rafael J. Wysocki wrote:
> On Monday, July 16, 2012, Rafael J. Wysocki wrote:
> > On Thursday, July 05, 2012, Rafael J. Wysocki wrote:
> > > On Wednesday, July 04, 2012, Mark Brown wrote:
> > > > I guess the OMAP hwmod stuff is the closest thing we've got at the
> > > > minute (I don't recall seeing any other implementations in mainline) but
> > > > the hwmods themselves don't appear in the DTS right now.  They have a
> > > > ti,hwmods property on each device naming the hwmod it's in, something
> > > > like that seems like a reasonable approach, possibly a reference to
> > > > another DT node rather than or as well as a string?  That seems fairly
> > > > easy.
> > > 
> > > Well, it looks like (and please tell me if I'm wrong) the hwmons are just
> > > string attributes that are parsed by the platform-specific code through
> > > a platform bus type notifier.
> > > 
> > > We could do that for power domains too, but then each platform wanting to
> > > use them would need to implement such a notifier and add its own routine
> > > for parsing those strings.  Would that be acceptable to everyone concerned?
> > 
> > I tried to follow the above suggestion and prepared the following patchset
> > that allows power domain information for Renesas platforms to be passed as
> > "renesas,pmdomain" string attribute of device nodes.  It adds functions
> > allowing the generic PM domains framework to use names for domain
> > identification in various situations and reworks the ARM/shmobile power domains
> > support code to used those functions instead of the "raw" ones that take
> > domain pointers as their arguments.  Finally, it defines a platform bus type
> > notifier that will add devices whose DT nodes contain the "renesas,pmdomain"
> > attribute to the power domains indicated by it (the value of that attribute
> > should be the name of the PM domain to add the device to after it's been
> > registered).  All of this should allow platform devices to be added to
> > appropriate power domains automatically based on the information read from
> > a DT.
> > 
> > The patches are on top of the current linux-next tree.
> > 
> > I've tested the patches that could be tested on the Mackerel board, except
> > for the last one (I'm still working on testing it).
> 
> Well, no comments, no objections.  Good!
> 
> I've just tested [14/14] too and it works as expected.

Sorry for taking so long to reply. I am really not that familiar with the
power domain requirements, but I do have two comments on your approach:

* I think when we want to add a generic concept to the device tree such
  as power domains, we should always make it specified in a generic way.
  You have used the "renesas,pmdomain" attribute, which is specific to
  one vendor and requires platform specific code to read it.
  Is there any reason not to put the code into the generic
  drivers/base/power/domain.c file (or near it) and make a binding that
  works for everyone?

* Mark suggested two options (string and phandle), and (you guessed it),
  I would much prefer the other one.
  IMHO using phandle makes it much easier to do this in a generic way,
  without having to document every possible string that this can be
  set to in the binding document. Obviously the phandle requires having
  a node in the device tree for each domain, but I think having that
  node is actually an advantage because it lets you describe the
  hierarchy of the domains there.

	Arnd
