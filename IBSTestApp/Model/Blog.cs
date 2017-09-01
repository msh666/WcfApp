using System.Runtime.Serialization;

namespace IBSTestApp.Model
{
    [DataContract]
    public class Blog
    {
        [DataMember]
        public long BlogId { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Url { get; set; }
        [DataMember]
        public long UserId { get; set; }
    }
}