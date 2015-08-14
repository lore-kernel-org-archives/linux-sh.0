From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 14 Aug 2015 21:48:57 +0000
Subject: Re: [PATCH v4 2/6] media: create a macro to get entity ID
Message-Id: <1784699.akJOgsu3YQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <89205b71de7a6edc3638eb14df8d0b0e4df32bc2.1439563682.git.mchehab@osg.samsung.com>
In-Reply-To: <89205b71de7a6edc3638eb14df8d0b0e4df32bc2.1439563682.git.mchehab@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

On Saturday 15 August 2015 00:08:55 Sakari Ailus wrote:
> On Fri, Aug 14, 2015 at 11:56:39AM -0300, Mauro Carvalho Chehab wrote:
> ...
> 
> > diff --git a/include/media/media-entity.h b/include/media/media-entity.h
> > index 8b21a4d920d9..478d5cd56be9 100644
> > --- a/include/media/media-entity.h
> > +++ b/include/media/media-entity.h
> > @@ -126,6 +126,8 @@ struct media_entity_graph {
> >  	int top;
> >  };
> > 
> > +#define entity_id(entity) ((entity)->id)
> > +
> >  int media_entity_init(struct media_entity *entity, u16 num_pads,
> >  		struct media_pad *pads);
> >  
> >  void media_entity_cleanup(struct media_entity *entity);
> 
> media-entity.h is a pretty widely included header file. Perhaps we should
> think about the naming a bit.
> 
> All the other names in the header begin with media (or __media); I'd very
> much prefer not changing that pattern.

I'd prefer naming it media_entity_id() as well.

Slightly nitpicking, wouldn't it also be better to make it a static inline 
function instead of a macro to ensure type safety ? No strong preference 
though.

-- 
Regards,

Laurent Pinchart

