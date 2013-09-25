From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Sep 2013 22:57:38 +0000
Subject: Re: [PATCH 1/3] media: i2c: Add ADV761X support
Message-Id: <1393674.bXtORIkseQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday 25 September 2013 18:31:51 Guennadi Liakhovetski wrote:
> On Wed, 25 Sep 2013, Valentine wrote:
> > On 09/25/2013 06:08 PM, Guennadi Liakhovetski wrote:

[snip]

> > > > > > +/* I2C I/O operations */
> > > > > > +static s32 adv_smbus_read_byte_data(struct i2c_client *client, u8
> > > > > > command)
> > > > > > +{
> > > > > > +	s32 ret, i;
> > > > > > +
> > > > > > +	for (i = 0; i < 3; i++) {
> > > > > > +		ret = i2c_smbus_read_byte_data(client, command);
> > > > > 
> > > > > Uhm, why do you need to do this 3 times?... I see adv7842 does that
> > > > > too...
> > > > > but e.g. adv7604 dies this only for writing and not for reading...
> > > > 
> > > > Just thought it would be safe to retry in case of a failure.
> > > > Other drivers seem to retry I2C I/O as well. This is probably related
> > > > to the possible cable issues. Not sure. Anyways, retrying doesn't seem
> > > > to hurt, does it?
> > > 
> > > It does, because it means there's something we don't understand. IMHO it
> > > should either work from the first time, or there should be an error,
> > > that we understand with a following error processing, that _might_
> > > include re-trying. Re-trying just in case isn't good. Especially if no
> > > error has been observed.
> > 
> > I have observed very rare errors when reading HDMI status. Just a couple
> > of times during this week. I'm not sure of the nature of those errors.
> > Just thought it would be OK to retry since other decoder drivers do so as
> > well.
> 
> Ok, understand. As I said, I personally don't like that, but, I think,
> Laurent will have a final word on this.

I don't like the idea of blindly retrying, especially for write operations. If 
a read fails due to a flaky cable, there's equal chances that a write would 
fail as well, which could result in writing random values to random registers. 
Given the side effects that this could have, I'd much rather not retry I/O 
operations and have the users fix electrical issues. Hiding something this 
serious could be dangerous.

-- 
Regards,

Laurent Pinchart

