From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Mar 2010 11:56:04 +0000
Subject: Re: [PATCH] driver core: Early dev_name() support.
Message-Id: <20100315115603.GA17028@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100309065753.GA8287@linux-sh.org> <ac3eb2511003111159q84e6cefi43de106c79c0e333@mail.gmail.com> <20100315080359.GA15171@linux-sh.org> <ac3eb2511003150429u5aa2e6c8w9ecfcc77293dd82b@mail.gmail.com>
In-Reply-To: <ac3eb2511003150429u5aa2e6c8w9ecfcc77293dd82b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Mar 15, 2010 at 12:29:23PM +0100, Kay Sievers wrote:
> On Mon, Mar 15, 2010 at 09:03, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Thu, Mar 11, 2010 at 08:59:18PM +0100, Kay Sievers wrote:
> 
> >> > ??static inline const char *dev_name(const struct device *dev)
> >> > ??{
> >> > + ?? ?? ?? /* Use the init name until the kobject becomes available */
> >>
> >> This should probably state that it's used for getting names out of
> >> unregistered devices. Otherwise it sounds confusing.
> >>
> > It's not clear that that distinction makes things any less confusing.
> > Early devices are registered, they just haven't been fully initialized
> > yet.
> 
> For the driver core, "registered" devices are devices where
> device_add() or device_register() has been called. Initialized devices
> are devices which device_initialize() was called for. The devices you
> mean are not "registered" in that sense, right?
> 
And you call that less confusing? The only dependency that dev_name() has
here is the kobject initialization, where we wait on device_add() to
clear the init name before switching over to the kobject name. However
the kobject initialization happens is ultimately immaterial.

All early devices have been added with early_platform_add_devices(), that
to me signifies an added and available device, regardless of whether it's
waiting around for the driver core to complete part of its initialization
at a later stage or not.

I have a hard time believing that the comment that we're waiting on the
kobject is in any way less confusing than some arbitrary redefinition of
"registered" vs "added" etc. that the driver core chooses to engage in
for arbitrary parts of the boot process.
