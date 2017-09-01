using System;
using System.Runtime.Serialization;

namespace IBSTestApp.Model
{
    [DataContract]
    public class Post
    {
        [DataMember]
        public long PostId { get; set; }
        [DataMember]
        public string Title { get; set; }
        [DataMember]
        public string Content { get; set; }
        [DataMember]
        public DateTime PublicationDate { get; set; }
        [DataMember]
        public long BlogId { get; set; }
    }
}