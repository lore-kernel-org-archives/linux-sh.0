From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 29 May 2012 07:40:08 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: tidyup: sound card detection order
Message-Id: <87k3zvmo4r.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx4rmqzd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx4rmqzd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Paul

Thank you for checking patch

> > > Is the problem that a previous patch altered the order of the
> > > ALSA index of the sound cards? And this patch restores the previous order?
> > > 
> > > If so, I wonder if this is really necessary as is should
> > > be possible to set the index using a module parameter if one
> > > is relying on it.
> > > 
> > One would expect so. What happens if the ALSA drivers are built as
> > modules and inserted in random order today? If you require persistent
> > assignment then you will have to deal with it either through module
> > parameters or udev.
> 
> I'm unsure if that was a rhetorical question or not,
> but I believe the answer is yes.

Yes.
The ALSA card list order was same as inserted alsa-module
order if it was built as module.
This is very OK.
And I'm not sure ALSA already has index specification method.

Sorry for my confusion.
My problem was deferred probe order on built-in.

Current my issue is...
  normal probe of ALSA-card.0  -> requests probe deferral
  normal probe of ALSA-card.1  -> requests probe deferral
  ...
  deferred-probe of ALSA-card.1  <= order changed
  deferred-probe of ALSA-card.0  <= order changed

Now, I re-checked and noticed that
the main issue was additional method for deferred_probe_pending_list on dd.c.

Below patch solved this issue.
What do you think this ?

------------------------------------------
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1b1cbb5..dcb8a6e 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -100,7 +100,7 @@ static void driver_deferred_probe_add(struct device *dev)
        mutex_lock(&deferred_probe_mutex);
        if (list_empty(&dev->p->deferred_probe)) {
                dev_dbg(dev, "Added to deferred list\n");
-               list_add(&dev->p->deferred_probe, &deferred_probe_pending_list);
+               list_add_tail(&dev->p->deferred_probe, &deferred_probe_pending_list);
        }
        mutex_unlock(&deferred_probe_mutex);
 }
------------------------------------------


Best regards
---
Kuninori Morimoto
